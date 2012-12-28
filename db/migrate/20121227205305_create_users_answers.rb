class CreateUsersAnswers < ActiveRecord::Migration
  def change
    create_table :users_answers do |t|
      t.integer "user_id"
      t.integer "answer_id"
      t.timestamps
    end
    add_index :users_answers, [:user_id, :answer_id], :unique => true
  end
end
