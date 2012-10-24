class AttendancesController < ApplicationController

  before_filter :authenticate_user!

  def rsvp
    id = params[:id]
    delete = params[:delete]
    @lesson = Lesson.find(id)

    if delete == "delete"
      current_user.attendances.find_by_lesson_id(id).destroy
    else
      current_user.attendances.create!(:lesson_id => id) if @lesson.present?
    end
  end

end
