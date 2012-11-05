class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :past_lessons, :admin?, :all_lessons, :future_lessons
  #contenteditable_filter "admin?"

  def past_lessons
    lessons = Lesson.all(:order => "RANDOM()", :limit => 4)
    lessons << Lesson.new if lessons.empty?
    lessons
  end

  def future_lessons
    all_lessons.select { |l| l.date > DateTime.now}
  end

  def admin?
    if user_signed_in?
      true if current_user.admin
    end
  end

  def admin_only
    unless current_user.admin == true
      redirect_to root_path
    end

  end

  def all_lessons
    Lesson.all
  end

end
