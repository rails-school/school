feature %q{
  I wanna test helpers
} do

  scenario "absolute path is properly generated" do
    helper.url_to(Lesson.create(:title => 'Hello')).should == 'http://test.host/l/hello'
  end

end
