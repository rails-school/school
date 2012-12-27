class AddSchoolsToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :school_id, :integer
  end
end
