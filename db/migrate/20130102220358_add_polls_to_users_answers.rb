class AddPollsToUsersAnswers < ActiveRecord::Migration
  def change
    add_column :users_answers, :poll_id, :integer
  end
end
