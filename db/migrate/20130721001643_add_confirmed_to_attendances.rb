class AddConfirmedToAttendances < ActiveRecord::Migration
  def change
    add_column :attendances, :confirmed, :boolean, default: false
  end
end
