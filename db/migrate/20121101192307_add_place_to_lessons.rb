class AddPlaceToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :place_id, :integer
  end
end
