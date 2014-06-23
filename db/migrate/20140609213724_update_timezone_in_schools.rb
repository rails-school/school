class UpdateTimezoneInSchools < ActiveRecord::Migration
  def change
    sf_school = School.find_by_slug("sf")
    unless sf_school.nil?
      sf_school.timezone = 'Pacific Time (US & Canada)'
      sf_school.save
    end

    cville_school = School.find_by_slug("cville")
    unless cville_school.nil?
      cville_school.timezone = 'Eastern Time (US & Canada)'
      cville_school.save
    end
  end
end
