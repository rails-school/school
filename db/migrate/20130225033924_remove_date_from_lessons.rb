class RemoveDateFromLessons < ActiveRecord::Migration
  def up
    remove_column :lessons, :date
  end

  def down
    add_column :lessons, :date, :datetime
  end
end
