class UsersSubscribedByDefault < ActiveRecord::Migration
  def up
    change_column :users, :subscribe, :boolean, :default => true
  end

  def down
    change_column :users, :subscribe, :boolean, :default => nil
  end
end
