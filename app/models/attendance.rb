class Attendance < ActiveRecord::Base
  attr_accessible :attended, :lesson_id, :user_id
end
