class SendgridEventService
  # Service Object to process event webhooks from SendGrid. Events not listed
  # in HANDLED_EVENTS will be ignored.
  HANDLED_EVENTS = %w[bounce spamreport]
  POST_URL = "https://api.sendgrid.com/api/spamreports.delete.json"

  def initialize(request_params: {})
    @request_params = request_params
  end

  def perform
    @request_params[:_json].each do |event|
      if event[:email].present? && HANDLED_EVENTS.include?(event[:event])
        user = User.find_by(email: event[:email])
        method_name = "process_#{event[:event]}_event".to_sym
        send(method_name, user) if user
      end
    end
  end

  private

  def process_bounce_event(user)
    unsubscribe_user(user)
  end

  def process_spamreport_event(user)
    # if the user does not have an unsubscribe token, then the user is actually
    # an email list. In this case we do not want to unsubscribe the user,
    # instead we want to delete the spam report at sendgrid
    if user.unsubscribe_token.present?
      unsubscribe_user(user)
    else
      delete_spam_report(user)
    end
  end

  def unsubscribe_user(user)
    user.update_attributes(subscribe_lesson_notifications: false,
                           subscribe_badge_notifications: false)
  end

  def delete_spam_report(user)
    post_params = { api_user: ENV["SENDGRID_USERNAME"],
                    api_key: ENV["SENDGRID_PASSWORD"] }
    HTTParty.post(POST_URL, query: post_params.merge!(email: user.email))
  end
end
