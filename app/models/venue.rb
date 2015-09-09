class Venue < ActiveRecord::Base
  has_many :lessons
  belongs_to :school
  acts_as_gmappable
  geocoded_by :gmaps4rails_address

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.state}, #{self.country}, #{self.zip}"
  end
  def formatted_address
    "#{self.name} - #{self.address}, #{self.city}, #{self.state}, #{self.country}, #{self.zip}"
  end
end
