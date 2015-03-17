require "sinatra/base"

class FakeBridgeTroll < Sinatra::Base
  get "/users/1/events" do
    status 200
    content_type :json
    '{"event_count": 15}'
  end
end
