class Attendance < ActiveRecord::Base
  validates :lesson_id, :uniqueness => {:scope => :user_id}
  belongs_to :user, touch: true
  belongs_to :lesson, touch: true
end
