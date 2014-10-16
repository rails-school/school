class AddSubscribeBadgeNotificationsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_badge_notifications, :boolean,
      default: true
  end
end
