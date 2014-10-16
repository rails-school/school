class ApplicationMailer < ActionMailer::Base
  default from: "Rails School <team@railsschool.org>"

  private
  def format_email_field(user)
    address = Mail::Address.new(user.email)
    address.display_name = user.name
    address.format
  end
end
