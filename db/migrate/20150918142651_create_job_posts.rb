class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|
      t.string :title
      t.text :description
      t.references :school, index: true, foreign_key: true
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :url

      t.timestamps null: false
    end
  end
end
