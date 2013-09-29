module ApplicationHelper
  def format_user_name(user)
    if user.hide_last_name? && !user.admin?
      user.name.split(" ").first
    else
      user.name
    end
  end

  def lesson_today(day)
    @lessons_this_month.find { |l| l.start_time.day == day }
  end

  def calendar_lesson(day, month)
    if month == Time.current.month
      @lessons_this_month.find { |l| l.start_time.day == day }
    else
      @future_lessons.find { |l| l.start_time.day == day && l.start_time.month == month }
    end
  end

  def lessons_between?(day_start, day_end)
    @lessons_this_month.find { |l| l.start_time.day >= day_start && l.start_time.day <= day_end }
  end

  def future_lessons_between?(day_start, day_end)
    @future_lessons.find { |l| l.start_time.day >= day_start && l.start_time.day <= day_end }
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

  def url_to(object)
    "#{root_url[0..root_url.length-2]}#{url_for(object)}"
  end
end
