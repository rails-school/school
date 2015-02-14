class NotificationsController < ApplicationController
  before_filter :authenticate_teacher

  def new
  end

  def create
    @subject = params[:notification][:subject]
    @message = params[:notification][:message]

    attendees = @lesson.users
    attendees.each do |attendee|
      NotificationMailer.send_lesson_message(
        @lesson.id, @subject, @message, attendee.id
      ).deliver_later
    end

    redirect_to @lesson, notice: "Notification was sent"
  end

  private
  def authenticate_teacher
    @lesson = Lesson.find_by_slug(params[:lesson_id])
    render status: :forbidden, text: "Access denied" unless can? :manage, :notifications
  end
end
