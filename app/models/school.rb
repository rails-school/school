class School < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :venues
end
