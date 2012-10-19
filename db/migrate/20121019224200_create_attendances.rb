class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.integer :lesson_id
      t.boolean :attended

      t.timestamps
    end

    add_index :attendances, [:user_id, :lesson_id], :unique => true

  end
end
