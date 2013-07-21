require 'spec_helper'

describe LessonsController do
  describe "GET /l/:id/whiteboard" do
    let(:user) { create(:user) }
    let!(:lesson) {
      create(:lesson, start_time: Time.now, end_time: Time.now + 2.hours)
    }
    let(:attendance) { create(:attendance, user: user, lesson: lesson) }

    before { sign_in(user) }

    it "marks the user's attendance as confirmed if during class" do
      attendance.confirmed.should be_false
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      attendance.reload.confirmed.should be_true
    end

    it "doesn't mark the user's attendance as confirmed if before class" do
      Timecop.travel(-1.hours)
      attendance.confirmed.should be_false
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      attendance.reload.confirmed.should be_false
      Timecop.return
    end

    it "doesn't mark the user's attendance as confirmed if after class" do
      Timecop.travel(2.hours)
      attendance.confirmed.should be_false
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      attendance.reload.confirmed.should be_false
      Timecop.return
    end
  end
end
