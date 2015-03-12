class Badge::JarJarBinks
  BADGE_ID = 4
  DISPLAY_NAME = "Jar Jar Binks"
  SLUG = "jarjarbinks"

  include Badge

  def description
    "Given to users who have attended one lesson."
  end

  def notification_bonus_message
    "Welcome to RailsSchool! We hope you enjoyed your first class."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 1
  end
end
