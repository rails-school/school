class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :data_type
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
