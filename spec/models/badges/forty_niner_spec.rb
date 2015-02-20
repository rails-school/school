require 'spec_helper'

describe Badge::FortyNiner do

  describe ".allocate_to_user?" do
    let(:user) { create(:user) }
    let(:sf_school) { create(:school, slug: "sf") }
    let(:noisebridge) { sf_school.venues.create }

    let!(:lessons) do
      17.times.map { |i|
        create(:lesson, venue: noisebridge, start_time: Time.now+i)
      }
    end

    subject { Badge::FortyNiner.allocate_to_user?(user) }

    context "user attended one of first 16 SF lessons" do
      before do
        create(:attendance, lesson: lessons[3], user: user, confirmed: true)
      end

      it { should eq(true) }
    end

    context "user did not attend one of first 16 SF lessons" do
      before do
        create(:attendance, lesson: lessons.last, user: user, confirmed: true)
      end

      it { should eq(false) }
    end
  end
end
