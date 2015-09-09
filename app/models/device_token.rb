class DeviceToken < ActiveRecord::Base
  def save
    # Escape token: remove arrows and spaces
    escaped_token = ""
    token.each_char do |c|
      escaped_token += c if c != " " && c != "<" && c != ">"
    end
    self.token = escaped_token

    # Save if it does not already exist
    return if DeviceToken.where("token = ?", self.token).count > 0
    super
  end
end
