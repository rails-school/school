class Lesson < ActiveRecord::Base
  attr_accessible :address, :city, :course_id, :date, :description, :title, :user_id

  has_many :attendances
  has_many :users, :through => :attendances

end
