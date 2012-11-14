class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :admin?
  contenteditable_filter "authenticate_user!"

  def admin?
    if user_signed_in?
      true if current_user.admin
    end
  end

  def admin_only
    unless current_user.admin == true
      redirect_to root_path
    end
  end
end
