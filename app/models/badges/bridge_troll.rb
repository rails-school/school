class Badge::BridgeTroll
  BADGE_ID = 10
  DISPLAY_NAME = "Bridge Troll"
  SLUG = "bridgetroll"

  include Badge

  def description
    "Given to users who have attended a RailsBridge class."
  end

  def notification_bonus_message
    "Congratulations, you've earned the Bridge Troll badge for attending a " \
    "RailsBridge class!"
  end

  def self.allocate_to_user?(user)
    user.rails_bridge_class_count > 0
  end
end
