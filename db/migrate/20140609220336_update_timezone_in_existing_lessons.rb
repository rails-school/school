class UpdateTimezoneInExistingLessons < ActiveRecord::Migration
  def change
    unless School.count == 0
      eastern_school = School.find(2)
      venue_ids = eastern_school.venues.pluck(:id)
      lessons = Lesson.where(venue_id: venue_ids)

      lessons.find_each do |l|
        Time.zone = Venue.find(l.venue_id).school.timezone
        l.start_time = Time.zone.parse("#{l.start_time}") - 3.hours
        l.end_time = Time.zone.parse("#{l.end_time}") - 3.hours
        l.save
      end
    end
  end
end
