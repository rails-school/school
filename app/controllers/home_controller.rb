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
    @lessons_this_month = Lesson.lessons_this_month
    @past_lessons = Lesson.past_lessons
    @future_lessons = Lesson.future_lessons
  end

end
