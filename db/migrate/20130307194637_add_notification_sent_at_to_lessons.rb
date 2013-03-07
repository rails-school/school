class AddNotificationSentAtToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :notification_sent_at, :datetime
  end
end
