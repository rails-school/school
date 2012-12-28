class Poll < ActiveRecord::Base
  attr_accessible :question
  has_many :answers
end
