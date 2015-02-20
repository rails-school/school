require 'spec_helper'

describe Badge::Teacher do

  describe ".allocate_to_user?" do
    let(:user) { create(:user) }
    let(:lesson) { create(:lesson, teacher: user, start_time: 1.week.ago, end_time: 1.week.ago + 2.hours)}
    let(:future_lesson) { create(:lesson, teacher: user, start_time: 1.week.from_now, end_time: 1.week.from_now + 2.hours)}

    subject { Badge::Teacher.allocate_to_user?(user) }

    context "user has not taught a lesson" do
      it { should eq(false) }
    end


    context "user has taught a lesson" do
      before do
        lesson
      end

      it { should eq(true) }
    end

    context "user will teach a lesson" do
      before do
        future_lesson
      end

      it { should eq(false) }
    end

  end
end
