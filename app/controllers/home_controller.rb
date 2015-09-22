class HomeController < ApplicationController

  def about
  end

  def calendar
  end

  def contact
  end

  def faq
  end

  def index
    @lessons_this_month = Lesson.for_school_id(current_school.id)
                            .lessons_this_month
    @past_lessons = Lesson.for_school_id(current_school.id).past_lessons
    @future_lessons = Lesson.for_school_id(current_school.id).future_lessons
    @job_posts = JobPost.where(school: current_school).active
  end

end
