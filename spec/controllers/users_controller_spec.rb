require 'spec_helper'

describe UsersController do
  describe "POST /bounce_reports" do
    let!(:user) { FactoryGirl.create(:user) }

    it "marks the associated user as unsubscribed" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("stewie", "cookie")
      post 'report_email_bounce', email: user.email, event: "bounce"
      response.status.should be(200)
      user.reload.subscribe.should be_false
    end

    it "fails when required params are missing" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("stewie", "cookie")
      post 'report_email_bounce', email: user.email
      response.status.should be(422)
      user.reload.subscribe.should be_true
    end

    it "fails when no credentials" do
      post 'report_email_bounce', email: user.email, event: "bounce"
      response.status.should be(401)
      user.reload.subscribe.should be_true
    end

    it "fails when bad credentials" do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("stewie", "cookie!")
      post 'report_email_bounce', email: user.email, event: "bounce"
      response.status.should be(401)
      user.reload.subscribe.should be_true
    end
  end
end
