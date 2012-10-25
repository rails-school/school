class AddSlugToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :slug, :string
    add_index :lessons, :slug, :unique => true
  end


end
