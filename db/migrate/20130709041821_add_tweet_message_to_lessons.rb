class AddTweetMessageToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :tweet_message, :string, limit: 140
  end
end
