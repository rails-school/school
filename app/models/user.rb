class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  has_many :attendances
  has_many :answers
  has_many :lessons, :through => :attendances

  def attend?(id)
    true if Attendance.find_by_lesson_id(id)
  end

  def answered?(q)
    true if self.answers.find_by_question_id(q.id)
  end

  def question
    qs = Question.all
    qs.each do |q|
      if self.answered?(q)
      else
        return q
      end

    end
    return nil
  end


end
