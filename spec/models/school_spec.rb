require 'spec_helper'

describe School do
  it { should have_many :users }
  it { should have_many :venues }

  let!(:venue) { create(:venue, school: subject) }

  describe "#next_available_date" do
    context "`school.day_of_week` is set" do
      subject { create(:school, day_of_week: "tuesday") }

      let(:coming_tuesday) { Chronic.parse("next #{subject.day_of_week}").to_date }
      let(:second_tuesday_from_now) { coming_tuesday + 1.week }
      let(:third_tuesday_from_now) { coming_tuesday + 2.weeks }

      context "some classes are coming up in a row" do

        before do
          create(:lesson, venue: venue, start_time: coming_tuesday + 7.hours)
          create(:lesson, venue: venue, start_time: second_tuesday_from_now + 7.hours)
        end

        it "returns the first day after the upcoming classes that lands on `day_of_week`" do
          expect(subject.next_available_date).to eq(second_tuesday_from_now + 1.week)
        end
      end

      context "some classes are coming up with a gap in between" do
        before do
          create(:lesson, venue: venue, start_time: coming_tuesday + 7.hours)
          create(:lesson, venue: venue, start_time: third_tuesday_from_now + 7.hours)
        end

        it "returns the first date in the gap that lands on `day_of_week`" do
          expect(subject.next_available_date).to eq(second_tuesday_from_now)
        end
      end


      context "no classes are coming up" do
        it "returns the next date from today that lands on `day_of_week`" do
          expect(subject.next_available_date).to eq(coming_tuesday)
        end
      end
    end

    context "`school.day_of_week` is missing" do
      subject { create(:school, day_of_week: nil) }

      it "returns today" do
        expect(subject.next_available_date).to eq(Time.current.to_date)
      end
    end
  end
end
