class ClearDescriptions < ActiveRecord::Migration
  def up
    Lesson.all.each do |l|
      l.description = ''
      l.save!
    end
  end

  def down
    Lesson.all.each do |l|
      l.description = l.summary
      l.save!
    end
  end
end
