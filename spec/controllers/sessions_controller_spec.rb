require 'spec_helper'

describe DeviseOverrides::SessionsController do
  describe "POST /users/sign_in.json" do
    context "with invalid credentials" do
      it "returns 401" do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        stub_current_school

        post :create, format: :json, user: {
          email: "foo",
          password: "",
          remeber_me: 1
        }
        expect(response.status).to eq(401)
      end
    end
  end
end
