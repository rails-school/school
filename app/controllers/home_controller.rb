class HomeController < ApplicationController
  def index
    @lessons = Lesson.all
    @past_lessons = Lesson.past_lessons
    @future_lessons = Lesson.future_lessons
  end

  def about
  end

  def calendar
  end

end
