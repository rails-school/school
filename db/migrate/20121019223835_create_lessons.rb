class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.datetime :date
      t.string :address
      t.string :city
      t.integer :course_id
      t.integer :user_id

      t.timestamps
    end

  end

end
