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

  describe "GET /l/future/slugs" do
    let!(:future_lessons) { create_list(:lesson, 2) }
    let!(:past_lesson) do
      create(:lesson, start_time: Time.now - 1.day,
             end_time: Time.now - 1.day + 2.hours)
    end

    before { get :future_lessons_slug }

    it "returns slugs for only future lessons" do
      expect(Lesson.count).to eq(3)
      expect(response).to be_success
      response_body = JSON.parse(response.body)
      expect(response_body.length).to eq(2)
      expect(response_body[0]).to be_a_kind_of(String)
    end
  end

  describe "GET /l/upcoming" do
    let!(:next_lesson) { create(:lesson, title: "next") }
    let!(:distant_lesson) do
      create(:lesson, start_time: Time.now + 1.month,
        end_time: Time.now + 1.month + 2.hours, title: "distant")
    end
    let!(:past_lesson) do
      create(:lesson, start_time: Time.now - 1.day,
             end_time: Time.now - 1.day + 2.hours)
    end

    before { get :upcoming }

    it "returns only the next upcoming lesson" do
      expect(Lesson.count).to eq(3)
      expect(response).to be_success
      response_body = JSON.parse(response.body)
      expect(response_body["title"]).to eq("next")
    end
  end

  describe "GET /attending_lesson/:lesson_slug" do
    let!(:user) { create(:user) }
    let!(:lesson) { create(:lesson) }
    let!(:attendance) { create(:attendance, user: user, lesson: lesson) }

    before { sign_in(user) }

    it "returns true if a user is attending a lesson" do
      get :attending_lesson, lesson_slug: lesson.slug
      expect(response).to be_success
      expect(response.body).to eq("true")
    end
    it "returns false if a user is not attending a lesson" do
      Attendance.first.destroy
      get :attending_lesson, lesson_slug: lesson.slug
      expect(response).to be_success
      expect(response.body).to eq("false")
    end
  end
end
