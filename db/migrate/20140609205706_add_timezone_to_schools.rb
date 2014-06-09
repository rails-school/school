class AddTimezoneToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :timezone, :string
  end
end
