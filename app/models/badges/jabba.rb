class Badge::Jabba
  BADGE_ID = 8
  DISPLAY_NAME = "Jabba"
  SLUG = "jabba"

  include Badge

  def description
    "Given to users who have attended 50 lessons."
  end

  def notification_bonus_message
    "Great work! You are growing great with knowledge."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 50
  end
end
