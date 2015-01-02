class Codewar < ActiveRecord::Base
  attr_accessible :user_id, :slug, :language
  
  belongs_to :user
end
