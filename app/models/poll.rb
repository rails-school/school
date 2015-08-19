class Poll < ActiveRecord::Base
  has_many :user_answers
  has_many :answers
end
