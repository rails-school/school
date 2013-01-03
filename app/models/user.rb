class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :async

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name

  has_many :attendances
  has_many :user_answers
  #has_many :answers
  has_many :lessons, :through => :attendances
  before_save :generate_unsubscribe_token

  def generate_unsubscribe_token
    unless encrypted_password.blank? # dummy users
      self.unsubscribe_token = (0..15).map{(65+rand(26)).chr}.join
    end
  end

  def attend?(class_id)
    Attendance.where(:lesson_id => class_id, :user_id => id).any?
  end

  def answered?(poll)
    UserAnswer.where(:poll_id => q.id, :user_id => id).any?
  end

  def next_unanswered_poll
    answered_poll_ids = (user_answers.empty? ? '' : user_answers.map(&:poll_id))
    Poll.where(['id not in (?)', answered_poll_ids]).first
  end
end
