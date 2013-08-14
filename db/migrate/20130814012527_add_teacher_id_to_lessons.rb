class AddTeacherIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :teacher_id, :integer
  end
end
