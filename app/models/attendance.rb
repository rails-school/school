class Attendance < ActiveRecord::Base
  attr_accessible :attended, :lesson_id

  belongs_to :user
  belongs_to :lesson
end
