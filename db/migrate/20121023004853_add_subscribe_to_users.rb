class AddSubscribeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe, :boolean
    add_column :users, :admin, :boolean
  end
end
