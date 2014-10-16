class Badge::Teacher
  BADGE_ID = 2
  DISPLAY_NAME = "Teacher"
  SLUG = "teacher"

  include Badge

  def description
    "Given to users that have taught a lesson."
  end

  def notification_bonus_message
    "Welcome to the faculty :)"
  end

  def self.allocate_to_user?(user)
    Lesson.past_lessons.find_by_teacher_id(user.id).present?
  end
end
