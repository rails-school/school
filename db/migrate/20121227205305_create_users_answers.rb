class CreateUsersAnswers < ActiveRecord::Migration
  def change
    create_table :users_answers do |t|
      t.integer "user_id"
      t.integer "answer_id"
      t.timestamps
    end
  end
end
