require "addressable/uri"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :async

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :name, :hide_last_name, :homepage, :subscribe, 
                  :github_username, :school_id

  has_many :attendances
  has_many :user_answers
  #has_many :answers
  has_many :lessons, :through => :attendances
  belongs_to :school
  
  before_save :generate_unsubscribe_token, :canonicalize_homepage
  validates_uniqueness_of :email

  def generate_unsubscribe_token
    unless encrypted_password.blank? # dummy users
      self.unsubscribe_token = (0..15).map{(65+rand(26)).chr}.join
    end
  end

  def canonicalize_homepage
    if homepage_changed?
      self.homepage = Addressable::URI.heuristic_parse(homepage).to_s
    end
  end

  def attend?(class_id)
    Attendance.where(:lesson_id => class_id, :user_id => id).any?
  end

  def answered?(poll)
    UserAnswer.where(:poll_id => q.id, :user_id => id).any?
  end

  def next_unanswered_poll
    if user_answers.any?
      Poll.where(['id not in (?)', user_answers.map(&:poll_id)]).first
    else
      Poll.first
    end
  end
end
