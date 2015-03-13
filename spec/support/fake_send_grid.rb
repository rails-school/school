require "sinatra/base"

class FakeSendGrid < Sinatra::Base
  get "/api/spamreports.get.json?" do
    content_type :text
    response = '[{"ip": "174.36.80.219","email": "example@aol.com",' \
               '"created": "2009-12-06 15:45:08"},{"ip": "74.63.202.105",' \
               '"email": "example2@yahoo.com",' \
               '"created": "2009-12-08 07:43:01"}]'
    response
  end

  post "/api/spamreports.delete.json" do
    content_type :json
    '{ "message": "success" }'
  end
end
