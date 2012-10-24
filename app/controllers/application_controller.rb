class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :past_lessons, :admin?
  #contenteditable_filter "admin?"

  def past_lessons
    Lesson.all(:order => "RANDOM()", :limit => 4)
  end

  def admin?
    if user_signed_in?
      current_user.admin
    end
  end
end
