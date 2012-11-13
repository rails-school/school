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

  def attend?(id)
    true if not Attendance.where(:lesson_id => id, :user_id => self.id).empty?
  end

  def answered?(q)
    true if self.answers.find_by_question_id(q.id)
  end

  def question
    Question.all.select {|q| !self.answered?(q) }[0]
  end


end
