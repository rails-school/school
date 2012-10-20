class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :past_lessons

  def past_lessons
    Lesson.all(:order => "RANDOM()", :limit => 3)
  end
end
