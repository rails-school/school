module ApplicationHelper
  def lessons_today?(year, month, day)
    Lesson.all.select { |l| l.date.month == month && l.date.day == day }
  end

  def title_content(page_title)
    site_name = 'Rails School San Francisco'
    page_title.present? ? "#{page_title} | #{site_name}" : site_name
  end
end
