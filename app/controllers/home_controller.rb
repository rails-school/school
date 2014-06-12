class HomeController < ApplicationController
  before_filter :set_time_zone, only: [:index]

  def about
  end

  def calendar
  end

  def contact
  end

  def faq
  end

  def index
    @lessons_this_month = Lesson.for_school(current_school).lessons_this_month
    @past_lessons = Lesson.for_school(current_school).past_lessons
    @future_lessons = Lesson.for_school(current_school).future_lessons
  end

end
