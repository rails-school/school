class AddTextToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :text, :text
  end
end
