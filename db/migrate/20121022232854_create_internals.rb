class CreateInternals < ActiveRecord::Migration
  def change
    create_table :internals do |t|
      t.string :about
      t.string :contact
      t.string :calendar

      t.timestamps
    end
  end
end
