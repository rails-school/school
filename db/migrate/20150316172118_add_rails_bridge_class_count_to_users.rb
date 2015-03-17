class AddRailsBridgeClassCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rails_bridge_class_count, :integer, default: 0
    add_index :users, :rails_bridge_class_count
  end
end
