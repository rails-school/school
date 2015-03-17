class UsersController < ApplicationController
  load_and_authorize_resource except:
    [:show, :unsubscribe, :notify_subscribers]

  skip_before_action :verify_authenticity_token, only: [:report_email_bounce]
  before_filter :authenticate_sendgrid_webhook, only: [:report_email_bounce]

  # GET /unsubscribe/:code
  def unsubscribe
    code = params[:code]
    @user = User.find_by_unsubscribe_token(code)
    case params[:notification_type]
    when "lesson"
      @user.subscribe_lesson_notifications = false
    when "badge"
      @user.subscribe_badge_notifications = false
    end

    @user.save!
  end

  # POST /notify_subscribers/1
  def notify_subscribers
    lesson = Lesson.find(params[:id])
    authorize! :notify, lesson
    User.where(subscribe_lesson_notifications: true,
               school: lesson.venue.school).each do |u|
      NotificationMailer.delay.lesson_notification(lesson.id, u.id,
                                                   current_user.id)
    end
    if LessonTweeter.new(lesson, current_user).tweet
      flash[:notice] = "Subcribers notified and tweet tweeted"
    else
      flash[:notice] = "Subscribers notified but error sending tweet, perhaps it was too long?"
    end
    lesson.update_attribute(:notification_sent_at, Time.now)
    redirect_to lesson_path(lesson)
  end

  # GET /users
  def index
    authorize! :manage, :all
  end

  # GET /users/1
  def show
    @user = User.includes(:user_badges, attendances: [:lesson])
                .find(params[:id])
  end

  # GET /users/1/edit
  def edit
  end

  # POST /bounce_reports
  def report_email_bounce
    SendgridEventService.new(request_params: params).perform
    head status: 200 # sendgrid demands a 200
  end

  # PUT /users/1
  def update
    if @user.update_attributes(params[:user])
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  private

  def authenticate_sendgrid_webhook
    unless params[:token] == ENV["SENDGRID_EVENT_TOKEN"]
      return head status: 401
    end
  end
end
