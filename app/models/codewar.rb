class Codewar < ActiveRecord::Base
  attr_accessible :user_id, :slug
  
  belongs_to :user
end
