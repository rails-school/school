class UpdateTimezoneInSchools < ActiveRecord::Migration
  def change
  	sf_school = School.find_by_slug("sf")
  	sf_school.timezone = 'Pacific Time (US & Canada)'
  	sf_school.save

  	cville_school = School.find_by_slug("cville")
  	cville_school.timezone = 'Eastern Time (US & Canada)'
  	cville_school.save
  end
end
