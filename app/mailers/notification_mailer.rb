class NotificationMailer < ApplicationMailer
  helper ApplicationHelper

  def lesson_notification(lesson_id, to_id, from_id)
    @lesson = Lesson.find(lesson_id)
    @user = User.find(to_id)
    from_user = User.find(from_id)
    # Takes timezone into account
    Time.zone = @lesson.venue.school.timezone
    @lesson.reload
    subject = "Rails class #{@lesson.start_time.strftime("%-m/%-d")}: #{@lesson.title}"
    calendar = @lesson.to_ics
    attachments['calendar.ics'] = calendar
    mail(to: format_email_field(@user), subject: subject,
         from: format_email_field(from_user))
  end

  def send_lesson_message(lesson_id, subject, message, user_id)
    @lesson = Lesson.find(lesson_id)
    @teacher = @lesson.teacher
    @user = User.find(user_id)
    @message = message
    mail(to: format_email_field(@user), subject: subject,
         from: format_email_field(@teacher))
  end
end
