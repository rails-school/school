class UpdateTimezoneInExistingLessons < ActiveRecord::Migration
  def change
  	eastern_school = School.find(2)
  	venues = eastern_school.venues.map {|v| v.id }
    lessons = Lesson.all.select {|l| venues.include? l.venue_id}

    lessons.each do |l|
      Time.zone = Venue.find(l.venue_id).school.timezone
      l.start_time = Time.zone.parse("#{l.start_time}") - 3.hours
      l.end_time = Time.zone.parse("#{l.end_time}") - 3.hours
      l.save
    end
  end
end
