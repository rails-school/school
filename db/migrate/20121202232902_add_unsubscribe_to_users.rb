class AddUnsubscribeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unsubscribe, :string
  end
end
