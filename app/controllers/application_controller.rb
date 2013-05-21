class ApplicationController < ActionController::Base
  #protect_from_forgery
  helper_method :admin?
  contenteditable_filter "admin?"

  def admin?
    user_signed_in? && current_user.admin
  end

  def admin_only
    redirect_to root_path unless admin?
  end
end
