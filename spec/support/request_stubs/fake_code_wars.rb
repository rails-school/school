require "sinatra/base"

class FakeCodeWars < Sinatra::Base
  CODEWARS_URL = "http://www.codewars.com/api/v1/users/"

  get "/api/v1/users/nbhartiya/code-challenges/completed" do
    json_response 200, "codewars.json"
  end

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + "/" + file_name, "rb").read
  end
end

WebMock.stub_request(:any, /codewars.com/).to_rack(FakeCodeWars)
