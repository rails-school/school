require 'spec_helper'

describe Lesson do

  describe "validation" do
    let(:lesson) { create(:lesson) }
    subject { lesson }

    # previous behavior limited tweets to 140
    describe "tweet_message length" do
      it "allows tweets of 255 characters" do
        tweet = "a" * 255
        lesson.tweet_message = tweet
        expect(lesson).to be_valid
      end
    end
  end

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

  describe "for_school_id" do
    it "contains lessons for venues in the school" do
      school = create(:school)
      venue1 = create(:venue, school: school)
      venue2 = create(:venue, school: school)
      lesson1 = create(:lesson, venue: venue1)
      lesson2 = create(:lesson, venue: venue2)

      lessons = Lesson.for_school_id(school.id)
      lessons.should include(lesson1)
      lessons.should include(lesson2)
    end

    it "doesn't contains lessons for venues outside the school" do
      school = create(:school)
      venue1 = create(:venue)
      Lesson.for_school_id(school.id).should_not include(venue1)
    end
  end
end
