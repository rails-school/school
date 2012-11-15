class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  has_many :attendances
  has_many :answers
  has_many :lessons, :through => :attendances

  def attend?(class_id)
    Attendance.where(:lesson_id => class_id, :user_id => id).present?
  end

  def answered?(q)
    answers.find_by_question_id(q.id).present?
  end

  def question
    Question.all.select {|q| !self.answered?(q) }[0]
  end
end
