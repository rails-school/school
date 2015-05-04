require 'spec_helper'

describe Lesson do

  describe "lessons_this_month" do
    it "contains this months's lessons" do
      Timecop.freeze(Time.local(2014,7,1,12,0,0)) do
        lesson1 = create(:lesson, start_time: 1.week.from_now)
        lesson2 = create(:lesson, start_time: 2.weeks.from_now)

        lessons = Lesson.lessons_this_month
        lessons.should include(lesson1)
        lessons.should include(lesson2)
      end
    end

    it "doesn't contain lessons from an earlier month" do
      lesson_past = create(:lesson, start_time: 6.weeks.ago)
      Lesson.lessons_this_month.should_not include(lesson_past)
    end

    it "doesn't contain lessons beyond this month" do
      lesson_future = create(:lesson, start_time: 6.weeks.from_now)
      Lesson.lessons_this_month.should_not include(lesson_future)
    end
  end

  describe "future_lessons" do
    it "contains future lessons" do
      # could this line fail if run just before a spring-forward daylight savings time switch?
      lesson1 = create(:lesson, start_time: 1.hour.from_now)
      lesson2 = create(:lesson, start_time: 2.weeks.from_now)

      lessons = Lesson.future_lessons
      lessons.should include(lesson1)
      lessons.should include(lesson2)
    end

    it "doesn't contain past lessons" do
      lesson_past = create(:lesson, end_time: 1.hour.ago)
      Lesson.future_lessons.should_not include(lesson_past)
    end
  end

  describe "past_lessons" do
    it "contains past lessons" do
      lesson1 = create(:lesson, end_time: 1.hour.ago)
      lesson2 = create(:lesson, end_time: 1.week.ago)

      lessons = Lesson.past_lessons
      lessons.should include(lesson1)
      lessons.should include(lesson2)
    end

    it "doesn't contain future lessons" do
      lesson_future = create(:lesson, start_time: 1.week.from_now)
      Lesson.past_lessons.should_not include(lesson_future)
    end

  end

  describe "for_school" do
    it "contains lessons for venues in the school" do
      school = create(:school)
      venue1 = create(:venue, school: school)
      venue2 = create(:venue, school: school)
      lesson1 = create(:lesson, venue: venue1)
      lesson2 = create(:lesson, venue: venue2)

      lessons = Lesson.for_school(school)
      lessons.should include(lesson1)
      lessons.should include(lesson2)
    end

    it "doesn't contains lessons for venues outside the school" do
      school = create(:school)
      venue1 = create(:venue)
      Lesson.for_school(school).should_not include(venue1)
    end
  end

  describe "future_lessons_for_school" do
    let(:school1) { create(:school) }
    let(:school2) { create(:school) }
    let(:venue1)  { create(:venue, school: school1) }
    let(:venue2)  { create(:venue, school: school2) }
    let(:lesson1) { create(:lesson, venue: venue1, title: "Lesson 1") }
    let(:lesson2) { create(:lesson, venue: venue2, title: "Lesson 2") }
    let(:lesson3) { create(:lesson, venue: venue1, title: "Lesson 3") }
    let(:past_lesson) do
      create(:lesson, venue: venue1, start_time: Time.now - 1.day,
        end_time: Time.now - 1.day + 2.hours)
    end

    context "with school provided" do
      let(:lessons) { Lesson.future_lessons_for_school(school1) }

      it "does not include lesson at a different school" do
        expect(lessons).not_to include(lesson2)
      end
      it "does not include past lesson" do 
        expect(lessons).not_to include(past_lesson)
      end
      it "includes future lessons at school provided" do
        expect(lessons).to match_array([lesson1, lesson3])
      end
    end

    context "with no school provided" do
      let(:lessons) { Lesson.future_lessons_for_school }

      it "does not include past lesson" do 
        expect(lessons).not_to include(past_lesson)
      end
      it "includes all future lessons" do
        expect(lessons).to match_array([lesson1, lesson2, lesson3])
      end
    end
  end
end
