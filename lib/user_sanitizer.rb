class User::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_up
    default_params.permit(:name, :email, :password, :password_confirmation, :current_password, :homepage, :github_username)
  end
end
