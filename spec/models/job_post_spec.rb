require 'spec_helper'

describe JobPost do
  it { should belong_to :school }

  describe "#href" do
    context "no url provided" do
      subject { create(:job_post, url: nil) }

      it "is a local link" do
        expect(subject.href).to eq(
          Rails.application.routes.url_helpers.job_post_path(subject))
      end
    end

    context "url provided" do
      subject { create(:job_post, url: 'http://stackexchange.com/job/post') }

      it "is an external link" do
        expect(subject.href).to eq(subject.url)
      end
    end
  end

  describe "#for_school_id" do
    it "contains job posts with the correct school id" do
      school = create(:school)
      post1 = create(:job_post, school: school)
      post2 = create(:job_post, school: school)

      posts = JobPost.for_school_id(school.id)
      posts.should include(post1)
      posts.should include(post2)
    end

    it "does not contain job posts with the incorrect school id" do
      school = create(:school)
      other_school = create(:school)
      post1 = create(:job_post, school: school)
      post2 = create(:job_post, school: other_school)
      post3 = create(:job_post, school: other_school)

      posts = JobPost.for_school_id(school.id)
      posts.should_not include(post2)
      posts.should_not include(post3)
    end
  end

  describe "#active" do
    it "includes job posts that have already started" do
      post = create(:job_post, starts_at: 1.day.ago)
      JobPost.active.should include(post)
    end

    it "includes job posts that have not ended" do
      post = create(:job_post, ends_at: 1.day.from_now)
      JobPost.active.should include(post)
    end

    it "does not include job posts that have not started" do
      post = create(:job_post, starts_at: 1.day.from_now,
                    ends_at: 2.days.from_now)
      JobPost.active.should_not include(post)
    end

    it "does not include job posts that have already ended" do
      post = create(:job_post, starts_at: 2.days.ago,
                    ends_at: 1.day.ago)
      JobPost.active.should_not include(post)
    end
  end
end
