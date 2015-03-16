class User::ParameterSanitizer < Devise::ParameterSanitizer
  private
  def sign_up
    default_params.permit(:name, :email, :password, :password_confirmation,
                          :current_password, :homepage, :github_username,
                          :school_id, :codewars_username, :bridge_troll_user_id)
  end
end
