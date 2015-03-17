require "sinatra/base"

class FakeSendGrid < Sinatra::Base
  post "/api/spamreports.delete.json" do
    content_type :json
    '{ "message": "success" }'
  end
end
