# coding: utf-8
require 'spec_helper'

feature %q{
  As a student
  I want to see job postings
} do

  background do
    @lesson = FactoryGirl.create(:lesson)
    @school = @lesson.venue.school
    @user = FactoryGirl.create(:user, school: @school)
    @job = FactoryGirl.create(:job_post, school: @school)

    sign_in_manually @user
  end


  scenario "view job listing" do
    visit root_path
    page.should have_text(@job.title)
  end

  scenario "visit job posting" do
    visit root_path
    page.find("a", text: @job.title).click
    page.should have_text(@job.description)
  end
end

feature %q{
  As an admin
  I want to create job posts
} do

  background do
    @lesson = FactoryGirl.create(:lesson)
    @school = @lesson.venue.school
    @admin = FactoryGirl.create(:admin, school: @school)
    @user = FactoryGirl.create(:user, school: @school)
    @job = FactoryGirl.build(:job_post, school: @school)

    sign_in_manually @admin
  end

  scenario "create job post" do
    visit new_job_post_path
    fill_in "job_post[title]", with: @job.title
    fill_in "job_post[description]", with: @job.description
    select @user.school.name, from: "job_post[school_id]"
    click_button "Save"

    click_link "Logout"
    sign_in_manually @user
    visit root_path
    page.should have_text(@job.title)
  end
end
