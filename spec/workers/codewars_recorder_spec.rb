require 'spec_helper'
require 'httparty'

describe CodewarsRecorder do
  describe ".perform_async" do
    let(:user) { create(:user, codewars_username:"nbhartiya") }
    let!(:codewars_count) {
      codewars_count = 0
      codewars_url = "http://www.codewars.com/api/v1/users/nbhartiya/" \
                     "code-challenges/completed"
      codewars_completed = HTTParty.get(codewars_url)["data"]
      codewars_completed.each do |exercise|
        exercise["completedLanguages"].each do |language|
          codewars_count += 1
        end
      end
      codewars_count
    }

    context "if the user has a codewars_username" do
      context "but already has one codewar populated" do
        let!(:codewar) do
          create(:codewar, user_id: user.id, slug: "multiply",
                           language: "clojure")
        end

        it "creats new codewars that are not already existing, resulting in correct codewars count" do
          CodewarsRecorder.perform_async(user.id, user.codewars_username)
          user.codewars.count.should == codewars_count
        end
      end

      context "and has no codewars populated" do
        it "creates all new codewars, resulting in correct codewars count" do
          CodewarsRecorder.perform_async(user.id, user.codewars_username)
          user.codewars.count.should == codewars_count
        end
      end
    end
  end
end
