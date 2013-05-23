class Attendance < ActiveRecord::Base
  attr_accessible :attended, :lesson_id
  validates :lesson_id, :uniqueness => {:scope => :user_id}
  belongs_to :user
  belongs_to :lesson, touch: true
end
