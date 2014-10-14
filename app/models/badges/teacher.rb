class Badge::Teacher
  BADGE_ID = 1
  SLUG = DISPLAY_NAME = "Teacher"

  include Badge

  def description
<<EOF
Given to users that have taught a lesson.
EOF
  end

  def self.allocate_to_user?(user)
    Lesson.past_lessons.find_by_teacher_id(user.id).present?
  end
end
