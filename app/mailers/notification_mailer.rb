class NotificationMailer < ActionMailer::Base
  default from: "team@railsschool.org"
  helper ApplicationHelper

  def lesson_notification(lesson, user, current_user)
    @lesson = lesson
    @user = user
    subject = "Rails class #{lesson.date.strftime("%-m/%-d")}: #{lesson.title}"
    mail(:to => format_email_field(user), :subject => subject,
         :from => format_email_field(current_user))
  end

  private
  def format_email_field(user)
    address = Mail::Address.new(user.email)
    address.display_name = user.name
    address.format
  end
end
