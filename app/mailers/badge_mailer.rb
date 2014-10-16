class BadgeMailer < ApplicationMailer

  def new_badge_notification(badge_id, user_id)
    @badge = Badge.find_by_badge_id(badge_id).new
    @user = User.find(user_id)

    subject = "Yay! You have received the #{@badge.display_name} badge on Rails School"
    mail(to: format_email_field(@user), subject: subject)
  end
end
