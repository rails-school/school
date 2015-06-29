class DeviceToken < ActiveRecord::Base
  def save
    escaped_token = ''
    token.each_char do |c|
      escaped_token += c if c != ' ' && c != '<' && c != '>'
    end
    token = escaped_token

    return if where('token = ?', token).count > 0

    super.save
  end
end
