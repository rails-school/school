class Badge::Codewarrior
  BADGE_ID = 3
  DISPLAY_NAME = "Codewarrior"
  SLUG = "codewarrior"

  include Badge

  def description
    "Given to users who have completed at least 5 ruby exercises on codewars."
  end

  def notification_bonus_message
    "Welcome, ruby codewarrior! You've mastered some ruby basics!"
  end

  def self.allocate_to_user?(user)
    user.codewars.count >= 5
  end
end
