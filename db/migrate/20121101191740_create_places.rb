class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :zip

      t.timestamps
    end
  end
end
