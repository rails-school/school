class BridgeTrollRecorder
  # Checks the number of RailsBridge classes attended by users who have given
  # us a BridgeTroll user id. Meant to be run nightly for all users
  include Sidekiq::Worker
  include HTTParty

  BRIDGE_TROLL_URL = "https://www.bridgetroll.org"

  def perform
    users = User.rails_bridge_users
    users.each do |user|
      url = "#{BRIDGE_TROLL_URL}/users/#{user.bridge_troll_user_id}/events"
      response = HTTParty.get(url)
      if response.code == 200
        class_count = response.parsed_response["event_count"]
        user.rails_bridge_class_count = class_count
        user.save
      end
    end
  end
end
