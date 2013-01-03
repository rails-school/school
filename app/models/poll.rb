class Poll < ActiveRecord::Base
  attr_accessible :question, :published
  has_many :answers
end
