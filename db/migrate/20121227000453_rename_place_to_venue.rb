class RenamePlaceToVenue < ActiveRecord::Migration
  def up
    rename_column :lessons, :place_id, :venue_id
  end

  def down
    rename_column :lessons,:venue_id, :place_id
  end
end
