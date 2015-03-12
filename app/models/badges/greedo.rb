class Badge::Greedo
  BADGE_ID = 6
  DISPLAY_NAME = "Greedo"
  SLUG = "greedo"

  include Badge

  def description
    "Given to users who have attended 15 lessons."
  end

  def notification_bonus_message
    "Great work! You are on your way to Force Enlightment."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 15
  end
end
