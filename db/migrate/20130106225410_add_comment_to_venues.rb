class AddCommentToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :comment, :string
  end
end
