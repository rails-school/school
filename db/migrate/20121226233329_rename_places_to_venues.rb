class RenamePlacesToVenues < ActiveRecord::Migration
  def up
    rename_table :places, :venues
  end

  def down
    rename_table :venues, :places
  end
end
