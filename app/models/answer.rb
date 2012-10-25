class Answer < ActiveRecord::Base
  attr_accessible :question_id, :text
  belongs_to :user
  belongs_to :question
end
