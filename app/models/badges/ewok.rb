class Badge::Ewok
  BADGE_ID = 5
  DISPLAY_NAME = "Ewok"
  SLUG = "ewok"

  include Badge

  def description
    "Given to users who have attended 5 lessons."
  end

  def notification_bonus_message
    "Congratulations! You are on the path."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 5
  end
end
