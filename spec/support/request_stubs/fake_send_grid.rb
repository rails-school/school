require "sinatra/base"

class FakeSendGrid < Sinatra::Base
  post "/api/spamreports.delete.json" do
    content_type :json
    '{ "message": "success" }'
  end
end

WebMock.stub_request(:any, /api.sendgrid.com/).to_rack(FakeSendGrid)
