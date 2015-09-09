class Lesson < ActiveRecord::Base
  has_many :attendances
  has_many :users, :through => :attendances
  before_save :generate_slug
  before_save :set_blank_archive_url
  belongs_to :venue
  belongs_to :teacher, class_name: "User"

  validates :tweet_message, length: { maximum: 140 }

  def generate_slug
    self.slug = Slug.new(title).generate if self.slug.blank?
  end

  def set_blank_archive_url
    archivable_hangout_url =
      /\Ahttps?:\/\/plus\.google\.com\/(?!.*hoaevent.*)(?=events\/.+)/i
    if archive_url.blank? && hangout_url.try(:match, archivable_hangout_url)
      self.archive_url = hangout_url
    end
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

  def self.for_school_id(school_id)
    self.joins(:venue).where(venues: { school_id: school_id })
  end

  def to_ics
    calendar = Icalendar::Calendar.new
    calendar.ip_method = "REQUEST"
    calendar.events << Icalendar::Event.new
    calendar.timezone do |t|
      t.tzid = ActiveSupport::TimeZone[
        venue.school.timezone].tzinfo.canonical_identifier
    end
    lesson = calendar.events.first
    # While the dtstart & dtend variables appear to have time zone information,
    # icalendar gem seems to remove it mand make them UTC
    lesson.dtstart = start_time
    lesson.dtend = end_time
    lesson.summary = self.title
    lesson.description = self.summary
    lesson.location = self.venue.formatted_address
    lesson.ip_class = "PUBLIC"
    lesson.created = self.created_at
    lesson.last_modified = self.updated_at
    lesson.uid = lesson.url = "http://#{Rails.application.routes.default_url_options[:host]}/l/#{self.slug}"
    calendar.to_ical
  end

  def as_json(opts={})
    super.merge(opts.slice(:students))
  end
end
