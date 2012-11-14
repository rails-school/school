class Lesson < ActiveRecord::Base
  attr_accessible :address, :city, :course_id, :date, :description, :title, :user_id, :slug

  has_many :attendances
  has_many :users, :through => :attendances
  before_save :generate_slug
  belongs_to :place



  def generate_slug
    self.slug = "#{self.title}"
    self.slug.gsub! /['`]/,""
    self.slug.gsub! /\s*@\s*/, " at "
    self.slug.gsub! /\s*&\s*/, " and "
    self.slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'
    self.slug.gsub! /-+/,"-"
    self.slug.gsub! /\A[-\.]+|[-\.]+\z/,""
    self.slug.downcase!
  end

  def url
    "/l/" + self.slug.to_s
  end

  def self.future_lessons
    the_time = Time.current - 7.hours
    self.all.select { |l| l.date.to_date >= the_time.to_date}
  end

end
