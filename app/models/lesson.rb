class Lesson < ActiveRecord::Base
  attr_accessible :address, :city, :course_id, :start_time, :end_time, :description, :title, :user_id, :slug, :venue_id, :summary

  has_many :attendances
  has_many :users, :through => :attendances
  before_save :generate_slug
  belongs_to :venue

  def generate_slug
    self.slug = Slug.new(title).generate if self.slug.blank?
  end

  def to_param
    slug || id
  end

  def self.future_lessons
    self.where("end_time > (?)", Time.current).order("start_time asc")
  end

  def self.past_lessons
    lessons = order("RANDOM()").limit(4)

    if lessons.empty?
      lessons << new
    end

    lessons
  end
end
