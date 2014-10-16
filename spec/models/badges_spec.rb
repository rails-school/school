require 'spec_helper'

describe "Badge.all" do
  let(:badges) { Badge.all }

  it "there should be several badges" do
    badges.length.should >= 2
  end

  it "they should have unique ids" do
    badges.map(&:id).uniq.length.should == badges.length
  end

  it "they should have unique slugs" do
    badges.map(&:slug).uniq.length.should == badges.length
  end

  it "they should have unique display_names" do
    badges.map { |b| b.new.display_name }.uniq.length.should ==
      badges.length
  end
end

Badge.all.each do |badge|
  describe "#{badge.new.display_name} badge" do
    subject { badge.new }

    it "has a display name" do
      subject.display_name.should be_present
    end

    it "has a description" do
      subject.description.should be_present
    end

    it "has a slug" do
      subject.slug.should be_present
    end

    it "has a notification_bonus_message" do
      subject.notification_bonus_message.should be_present
    end
  end
end
