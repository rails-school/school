class Badge::Teacher
  BADGE_ID = 2
  DISPLAY_NAME = "Teacher"
  SLUG = "teacher"

  include Badge

  def description
<<EOF
Given to users that have taught a lesson.
EOF
  end

  def notification_bonus_message
<<EOF
Welcome to the faculty :)
EOF
  end

  def self.allocate_to_user?(user)
    Lesson.past_lessons.find_by_teacher_id(user.id).present?
  end
end
