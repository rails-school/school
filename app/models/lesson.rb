class Lesson < ActiveRecord::Base
  attr_accessible :start_time, :end_time, :description, :title, :slug, :venue_id, :summary, :tweet_message, :image_social

  has_many :attendances
  has_many :users, :through => :attendances
  before_save :generate_slug
  belongs_to :venue
  belongs_to :teacher, class_name: "User"

  def generate_slug
    self.slug = Slug.new(title).generate if self.slug.blank?
  end

  def to_param
    slug || id
  end

  def self.lessons_this_month
    from = Time.current.beginning_of_month
    to = Time.current.end_of_month

    self.where(start_time: (from..to))
  end

  def self.future_lessons
    self.where("end_time > (?)", Time.current).order("start_time asc")
  end

  def self.past_lessons(limit=4)
    lessons = self.where("end_time < (?)", Time.current)
                  .order("RANDOM()").limit(limit)

    if lessons.empty?
      lessons << new
    end

    lessons
  end

  def self.for_school(school)
    self.joins(:venue).where(venues: {school_id: school.id})
  end

  def to_ics
    calendar = Icalendar::Calendar.new
    calendar.ip_method = "REQUEST"
    calendar.events << Icalendar::Event.new
    lesson = calendar.events.first
    lesson.dtstart = self.start_time
    lesson.dtend = self.end_time
    lesson.summary = self.title
    lesson.description = self.summary
    lesson.location = self.venue.formatted_address
    lesson.ip_class = "PUBLIC"
    lesson.created = self.created_at
    lesson.last_modified = self.updated_at
    lesson.uid = lesson.url = "http://#{Rails.application.routes.default_url_options[:host]}/l/#{self.slug}"
    calendar.to_ical
  end

end
