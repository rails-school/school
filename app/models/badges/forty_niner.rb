# Badge given to users that attended one of the first 16 lessons in SF
class Badge::FortyNiner
  BADGE_ID = 1
  SLUG = DISPLAY_NAME = "49er"

  include Badge

  def description
<<EOF.strip
Given to users that attended one of the first 16 lessons in San Francisco.
EOF
  end

  def notification_bonus_message
<<EOF.strip
Thank you for your critical role getting Rails School San Francisco off the ground.
EOF
  end

  def self.allocate_to_user?(user)
    user_lessons_attended_ids = user.attendances.select { |a| a.confirmed? }.map(&:lesson_id)
    sf_venues_ids = Venue.joins(:school).where("schools.slug = 'sf'").pluck(:id)
    first_ten_lessons_in_sf_ids = Lesson.where(venue_id: sf_venues_ids).order("start_time").limit(16).pluck(:id)
    (user_lessons_attended_ids & first_ten_lessons_in_sf_ids).any?
  end
end
