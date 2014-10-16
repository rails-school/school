class NotificationMailerPreview < ActionMailer::Preview
  def lesson_notification
    lesson = Lesson.last
    NotificationMailer.lesson_notification(lesson.id, User.first.id,
                                           lesson.teacher.id)
  end
end
