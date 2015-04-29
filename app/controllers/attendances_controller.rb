class AttendancesController < ApplicationController

  before_filter :authenticate_user!

  def rsvp
    id = params[:id]
    delete = params[:delete]
    @lesson = Lesson.find(id)

    if delete == "delete"
      current_user.attendances.find_by_lesson_id(id).destroy
    elsif @lesson.present?
      current_user.rsvp_for(@lesson)
      # When someone RSVP's for a lesson, the below line will update their codewars data.
      enqueue_codewars_recorder(current_user)
    end

    respond_to do |format|
      format.js
      format.json { render json: nil, status: 200 }
    end
  end

end
