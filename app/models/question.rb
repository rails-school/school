class Question < ActiveRecord::Base
  attr_accessible :data_type, :description, :title, :body
  has_many :answers



end
