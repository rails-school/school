class PollsRefactoring < ActiveRecord::Migration
  def up
    drop_table :questions
    remove_columns :answers, :user_id, :question_id, :text

#    remove_column :answers, :question_id, :integer
#    remove_column :answers, :text, :text

    add_column :answers, :poll_id, :integer
    add_column :answers, :text, :text
  end

  def down
    remove_column :answers, :poll_id
    remove_column :answers, :text

    add_column :answers, :user_id, :integer
    add_column :answers, :question_id, :integer
    add_column :answers, :text, :text

    create_table :questions do |t|
      t.string :data_type
      t.string :title
      t.text :description

      t.timestamps
    end

  end
end


