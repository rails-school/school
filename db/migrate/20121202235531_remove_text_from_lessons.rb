class RemoveTextFromLessons < ActiveRecord::Migration
  def up
    remove_column :lessons, :text
  end

  def down
    add_column :lessons, :text, :text
  end
end
