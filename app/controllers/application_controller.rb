require "user_sanitizer"

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  contenteditable_filter "admin?"

  def admin?
    user_signed_in? && current_user.admin
  end

  def admin_only
    redirect_to root_path unless admin?
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end
end
