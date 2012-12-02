class AddSummariesToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :summary, :text
  end
end
