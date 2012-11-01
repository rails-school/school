module ApplicationHelper

  def lessons_today?(year, month, day)
    all_lessons.select { |l| l.date.month == month && l.date.day == day }
  end
end
