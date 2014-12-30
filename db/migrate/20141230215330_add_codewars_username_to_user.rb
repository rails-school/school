class AddCodewarsUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :codewars_username, :string
  end
end
