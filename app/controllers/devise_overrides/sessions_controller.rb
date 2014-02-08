class DeviseOverrides::SessionsController < Devise::SessionsController
  def create
    if params[:user_return_to].present?
      session[:user_return_to] = params[:user_return_to]
    end
    super
    if params[:rsvp_for].present?
      lesson = Lesson.find(params[:rsvp_for])
      current_user.rsvp_for(lesson)
    end
  end
end
