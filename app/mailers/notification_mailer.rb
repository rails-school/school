class NotificationMailer < ActionMailer::Base
  default from: "team@railsschool.org"
  helper ApplicationHelper

  def lesson_notification(lesson_id, to_id, from_id)
    @lesson = Lesson.find(lesson_id)
    @user = User.find(to_id)
    from_user = User.find(from_id)
    subject = "Rails class #{@lesson.date.strftime("%-m/%-d")}: #{@lesson.title}"
    mail(:to => format_email_field(@user), :subject => subject,
         :from => format_email_field(from_user))
  end

  private
  def format_email_field(user)
    address = Mail::Address.new(user.email)
    address.display_name = user.name
    address.format
  end
end
