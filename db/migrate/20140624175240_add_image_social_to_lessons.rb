class AddImageSocialToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :image_social, :string
  end
end
