require "houston"

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

    school = lesson.venue.school
    next_up_lesson = Lesson.for_school_id(school.id).future_lessons.first

    if next_up_lesson == lesson
      User.where(subscribe_lesson_notifications: true,
                 school: lesson.venue.school).each do |u|
        begin
          NotificationMailer.delay.lesson_notification(lesson.id, u.id,
                                                       current_user.id)
        rescue StandardError => e
          Rails.logger.info "Error enqueueing #{u.email}: #{e}"
        end
      end
      if LessonTweeter.new(lesson, current_user).tweet
        flash[:notice] = "Subcribers notified and tweet tweeted"
      else
        flash[:notice] = "Subscribers notified but error sending tweet, \
perhaps it was too long?"
      end

      emit_lesson_notification_on_socket lesson
      lesson.update_attribute(:notification_sent_at, Time.now)
    else
      flash[:error] =
        %{Please wait until the lesson "#{next_up_lesson.title}" \
has finished before notifying subscribers}
    end
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
    respond_to do |format|
      format.html
      format.json do
        render json: @user.as_json(only: [:id, :name, :email, :hide_last_name])
      end
    end
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
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  # PUT /users/device-token
  def save_device_token
    args = params.require :token
    DeviceToken.new(token: args).save

    render json: nil, status: :created
  end

  private

  def authenticate_sendgrid_webhook
    unless params[:token] == ENV["SENDGRID_EVENT_TOKEN"]
      return head status: 401
    end
  end

  # Send the lesson (for which a notification is being sent) to a Node
  # server with socket.io; the Node server will then send the lesson to
  # all mobile devices subscribed to a channel
  def emit_lesson_notification_on_socket(lesson)
    # Notify iOS apps
    DeviceToken.all.each do |dt|
      IOSNotificationSender.perform_async(dt.as_json, lesson.as_json)
    end

    # Notify socket listeners (Android)
    if Rails.env.production?
      server_addr = "https://rssf-pusher.herokuapp.com"
      socket = SocketIO::Client::Simple.connect server_addr
      message = lesson.as_json

      socket.emit "lessonNotification", message
      socket.on :connect do
        socket.emit "lessonNotification", message
      end
    end
  end

  def user_params
    params.require(:user).permit(
      :bridge_troll_user_id, :codewars_username, :email, :github_username,
      :hide_last_name, :homepage, :name, :school_id,
      :subscribe_badge_notifications, :subscribe_lesson_notifications
    )
  end
end
