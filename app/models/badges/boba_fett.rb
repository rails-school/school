class Badge::BobaFett
  BADGE_ID = 7
  DISPLAY_NAME = "Boba Fett"
  SLUG = "bobafett"

  include Badge

  def description
    "Given to users who have attended 35 lessons."
  end

  def notification_bonus_message
    "Your knowledge is feared across many galaxies."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 35
  end
end
