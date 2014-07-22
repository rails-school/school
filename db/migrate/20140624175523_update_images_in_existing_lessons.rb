class UpdateImagesInExistingLessons < ActiveRecord::Migration
  def change
    Lesson.all.each do |l|
      l.image_social = "logo.png"
      l.save
    end
  end
end
