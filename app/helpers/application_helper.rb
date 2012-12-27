module ApplicationHelper
  def lessons_today?(year, month, day)
    Lesson.all.select { |l| l.date.month == month && l.date.day == day }
  end

  def title_content(page_title)
    site_name = 'Rails School San Francisco'
    page_title.present? ? "#{page_title} | #{site_name}" : site_name
  end

  def format_date(date)
    date.try(:strftime, "%B %e, %Y")
  end

  def format_time(time)
    t = time.try(:strftime, "%l:%M%p").downcase
    t.sub(':00', '')
  end

  def format_datetime(date)
    "#{format_time(date)} on #{format_date(date)}"
  end

  def notify_subscribers_link(lesson)
    content_tag :a, "notify subscribers", :href => "#{root_url}notify_subscribers/#{lesson.id}", 'data-method' => 'POST', 'data-remote' => true
  end
end
