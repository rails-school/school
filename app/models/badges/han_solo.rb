class Badge::HanSolo
  BADGE_ID = 9
  DISPLAY_NAME = "Han Solo"
  SLUG = "hansolo"

  include Badge

  def description
    "Given to users who have attended 100 lessons."
  end

  def notification_bonus_message
    "Youa are now the coolest person in RailsSchool."
  end

  def self.allocate_to_user?(user)
    user.attendances.where(confirmed: true).count >= 100
  end
end
