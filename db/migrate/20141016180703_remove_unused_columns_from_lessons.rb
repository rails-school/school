class RemoveUnusedColumnsFromLessons < ActiveRecord::Migration
  def change
    remove_column :lessons, "address"
    remove_column :lessons, "city"
    remove_column :lessons, "course_id"
    remove_column :lessons, "user_id"
    remove_column :lessons, "level_id"
  end
end
