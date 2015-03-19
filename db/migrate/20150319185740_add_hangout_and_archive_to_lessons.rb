class AddHangoutAndArchiveToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :hangout_url, :string
    add_column :lessons, :archive_url, :string
  end
end
