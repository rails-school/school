class PollsRefactoring < ActiveRecord::Migration
  def up
    drop_table :questions
    remove_column :answers, [:user_id, :question_id, :text]
    add_column :answers, :poll_id, :integer
    add_column :answers, :text, :text
  end

  def down
    create_table :questions
    add_column :answers, :user_id, :integer
    add_column :answers, :question_id, :integer
    add_column :answers, :text, :text
    remove_column :answers, :poll_id
    remove_column :answers, :text
  end
end


