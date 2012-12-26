class NotificationMailer < ActionMailer::Base
  default from: "team@railsschool.org"
  helper ApplicationHelper

  def lesson_notification(lesson, user, current_user)
    @lesson = lesson
    @user = user
    mail(:to => user.email, :subject => "Rails School SF new class on #{lesson.date}: #{lesson.title}", :from => current_user.email)
  end

end
