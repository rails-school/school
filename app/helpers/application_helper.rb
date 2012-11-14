module ApplicationHelper
  def lessons_today?(year, month, day)
    Lesson.all.select { |l| l.date.month == month && l.date.day == day }
  end
end
