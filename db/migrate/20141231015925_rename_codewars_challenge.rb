class RenameCodewarsChallenge < ActiveRecord::Migration
  def up
    rename_column :lessons, :codewars_challenge, :codewars_challenge_slug
  end
  def down
    rename_column :lessons, :codewars_challenge_slug, :codewars_challenge
  end
end
