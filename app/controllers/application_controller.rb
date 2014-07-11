require_dependency "user_sanitizer"

class ApplicationController < ActionController::Base
  around_filter :set_time_zone

  protect_from_forgery
  helper_method :current_school

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def current_school
    unless @current_school
      if params[:school]
        @current_school = School.find_by_slug(params[:school])
      elsif session[:school]
        @current_school = School.find_by_slug(session[:school])
      elsif current_user
        @current_school = current_user.school
      end
    end

    unless @current_school
      if @lesson
        @current_school = @lesson.venue.school
      end
    end

    unless @current_school
      begin
        loc = request.location
        @current_school = Venue.near([loc.latitude, loc.longitude], 5000)
                               .first
                               .school
      rescue StandardError
      end
    end

    unless @current_school
      @current_school = Venue.order("created_at").first.school
    end

    binding.pry unless @current_school
    session[:school] = @current_school.slug
    @current_school
  end

  def set_time_zone(&block)
    Time.use_zone(current_school.timezone, &block)
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
