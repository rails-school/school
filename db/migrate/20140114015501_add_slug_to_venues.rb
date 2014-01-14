class AddSlugToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :slug, :string
  end
end
