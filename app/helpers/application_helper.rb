module ApplicationHelper

  def lessons_today?(year, month, day)
    lessons = []
    all = all_lessons.each do |l|
      if l.date.month == month && l.date.day == day
        lessons << l
      end
    end

    lessons

  end
end
