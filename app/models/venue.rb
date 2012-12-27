class Venue < ActiveRecord::Base
  attr_accessible :address, :city, :country, :state, :zip, :name
  has_many :lessons
  belongs_to :school
  acts_as_gmappable

  def gmaps4rails_address
#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.address}, #{self.city}, #{self.state}, #{self.country}, #{self.zip}"
  end
end
