class BadgeAllocator
  include Sidekiq::Worker

  def perform(user_id)
    user = User.includes(:attendances, :user_badges).find(user_id)
    user_badge_ids = user.user_badges.map(&:badge_id)
    Badge.each do |badge|
      unless user_badge_ids.include?(badge.id)
        if badge.allocate_to_user?(user)
          UserBadge.create(badge_id: badge.id, user_id: user.id)
          if user.subscribe_badge_notifications?
            # TODO limit badge notifications to once in a certain interval
            BadgeMailer.new_badge_notification(
              badge.id, user.id
            ).deliver_now
          end
        end
      end
    end
  end
end
