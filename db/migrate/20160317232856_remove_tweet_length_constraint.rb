class RemoveTweetLengthConstraint < ActiveRecord::Migration
  def change
    change_column :lessons, :tweet_message, :string, limit: nil
  end
end
