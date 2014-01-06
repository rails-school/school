class RsvpsMetric < Prosperity::Metric
  scope { Attendance }

  School.all.each do |school|
    option(school.name) do |scope|
      user_ids = school.users.map(&:id)
      scope.where(user_id: user_ids)
    end
  end
end
