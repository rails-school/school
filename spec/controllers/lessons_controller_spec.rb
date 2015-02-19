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
      expect(attendance.reload).not_to be_confirmed
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      expect(attendance.reload).to be_confirmed
    end

    it "doesn't mark the user's attendance as confirmed if before class" do
      Timecop.travel(-1.hours)
      expect(attendance.reload).not_to be_confirmed
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      expect(attendance.reload).not_to be_confirmed
      Timecop.return
    end

    it "doesn't mark the user's attendance as confirmed if after class" do
      Timecop.travel(2.hours)
      expect(attendance.reload).not_to be_confirmed
      get "show", id: lesson.id, whiteboard: true
      response.should be_success
      expect(attendance.reload).not_to be_confirmed
      Timecop.return
    end
  end
end
