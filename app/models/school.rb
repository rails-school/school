class School < ActiveRecord::Base
  has_many :users
  has_many :venues

  enum day_of_week: Hash[Date::DAYNAMES.map(&:downcase).each_with_index.to_a]

  def next_available_date
    return Date.current.to_date unless day_of_week.present?

    upcoming_lessons = Lesson.joins(:venue).merge(venues)
                         .where("start_time > ?", Time.current)
                         .order("start_time asc")

    candidate_date = Chronic.parse("next #{day_of_week}").to_date

    upcoming_lessons.each_with_index do |lesson, i|
      # have we found a gap?
      break if candidate_date != lesson.start_time.to_date

      candidate_date = candidate_date + 1.week
    end

    candidate_date
  end
end
