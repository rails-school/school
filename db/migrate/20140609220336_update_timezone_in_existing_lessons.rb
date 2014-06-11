class UpdateTimezoneInExistingLessons < ActiveRecord::Migration
  def change
    lessons = Lesson.where(venue_id: 2)

    lessons.each do |l|
      Time.zone = Venue.find(l.venue_id).school.timezone
      l.start_time = Time.zone.parse("#{l.start_time}") - 3.hours
      l.end_time = Time.zone.parse("#{l.end_time}") - 3.hours
      l.save
    end
  end
end
