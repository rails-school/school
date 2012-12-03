class AddUnsubscribeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unsubscribe_token, :string
  end
end
