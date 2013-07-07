class AddLevelToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :level_id, :integer
  end
end
