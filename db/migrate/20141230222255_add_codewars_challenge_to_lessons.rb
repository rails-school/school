class AddCodewarsChallengeToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :codewars_challenge, :string
    add_column :lessons, :codewars_challenge_language, :string
  end
end
