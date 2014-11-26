class AddDayOfWeekToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :day_of_week, :integer
  end
end
