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
    @lessons = Lesson.all
    @past_lessons = Lesson.past_lessons
    @future_lessons = Lesson.future_lessons
  end

end
