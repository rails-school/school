class AddGmapsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :gmaps, :boolean
    add_column :places, :latitude, :float
    add_column :places, :longitude, :float
  end
end
