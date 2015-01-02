class CreateCodewars < ActiveRecord::Migration
  def change
    create_table :codewars do |t|
      t.integer :user_id
      t.string :slug

      t.timestamps
    end
  end
end
