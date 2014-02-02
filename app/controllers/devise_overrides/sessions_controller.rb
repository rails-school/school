class DeviseOverrides::SessionsController < Devise::SessionsController
  def create
    super
    if params[:rsvp_for].present?
      lesson = Lesson.find(params[:rsvp_for])
      current_user.rsvp_for(lesson)
    end
  end
end
