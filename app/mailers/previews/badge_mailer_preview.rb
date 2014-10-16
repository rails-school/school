class BadgeMailerPreview < ActionMailer::Preview
  Badge.each do |badge|
    define_method "new_#{badge.new.display_name}_badge_notification" do
      BadgeMailer.new_badge_notification(badge.id, User.first.id)
    end
  end
end
