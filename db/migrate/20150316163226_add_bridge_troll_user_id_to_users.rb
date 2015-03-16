class AddBridgeTrollUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bridge_troll_user_id, :string, default: ""
    add_index :users, :bridge_troll_user_id
  end
end
