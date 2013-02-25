module ApplicationHelper
  def lessons_today?(year, month, day)
    Lesson.all.select { |l| l.start_time.month == month && l.start_time == day }
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

  def format_datetime(start_time, end_time=nil)
    t = format_time(start_time)
    t += " - #{format_time(end_time)}" if end_time
    t + " on #{format_date(start_time)}"
  end

  def notify_subscribers_link(lesson)
    content_tag :a, "notify subscribers", :href => "#{root_url}notify_subscribers/#{lesson.id}", 'data-method' => 'POST', 'data-remote' => true
  end

  def url_to(object)
    "#{root_url[0..root_url.length-2]}#{url_for(object)}"
  end
end
