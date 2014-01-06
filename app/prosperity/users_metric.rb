class UsersMetric < Prosperity::Metric
  scope { User }

  School.all.each do |school|
    option(school.name) do |scope|
      scope.where(school_id: school.id)
    end
  end
end
