class AddLastCodewarsCheckedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_codewars_checked_at, :datetime
  end
end
