class Poll < ActiveRecord::Base
  attr_accessible :question, :published
  has_many :user_answers
  has_many :answers
end
