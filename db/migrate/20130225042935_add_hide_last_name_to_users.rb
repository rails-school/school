class AddHideLastNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hide_last_name, :boolean, :default => true
    User.all.each do |u|
      u.hide_last_name = true
      u.save
    end
  end
end
