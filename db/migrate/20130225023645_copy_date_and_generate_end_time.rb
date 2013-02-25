class CopyDateAndGenerateEndTime < ActiveRecord::Migration
  def up
    Lesson.all.each do |l|
      l.start_time = l.date
      l.end_time = l.date + 2.hours
      l.save
    end
  end

  def down
    Lesson.all.each do |l|
      l.date = l.start_time
      l.save
    end
  end
end
