class AddSchoolToUsers < ActiveRecord::Migration
  def up
    add_column :users, :school_id, :integer
    add_index :users, :school_id
    execute "UPDATE users SET school_id=1"
  end
  
  def down
    remove_column :users, :school_id
  end
end
