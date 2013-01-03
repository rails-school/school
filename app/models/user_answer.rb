class UserAnswer < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :poll
  belongs_to :answer

end
