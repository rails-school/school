class RenameUsersAnswers < ActiveRecord::Migration
  def up
    rename_table :users_answers, :user_answers
  end

  def down
    rename_table :user_answers, :users_answers
  end
end
