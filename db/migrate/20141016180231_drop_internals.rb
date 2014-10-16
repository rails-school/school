class DropInternals < ActiveRecord::Migration
  def change
    drop_table :internals
  end
end
