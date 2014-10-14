class AddLastBadgesCheckedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_badges_checked_at, :datetime
  end
end
