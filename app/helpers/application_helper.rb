# coding: utf-8
module ApplicationHelper

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
    school_name = (@lesson.nil? || @lesson.venue.nil?) ? current_school.name : @lesson.venue.school.name
    site_name = "Rails School #{school_name}"
    page_title.present? ? "#{page_title} | #{site_name}" : site_name
  end

  def format_date(date)
    # Converts time into the current school's timezone
    date = Time.zone.parse(date.to_s).to_date
    date.try(:strftime, "%B %e, %Y")
  end

  def format_time(time)
    # Converts time into the current school's timezone
    time = Time.zone.parse(time.to_s)
    zone = time.try(:strftime, "%Z").downcase
    case zone
      when "pdt", "pst"
        zone = "Pacific"
      when "edt", "est"
        zone = "Eastern"
    end
    t = time.try(:strftime, "%l:%M%p").downcase
    "#{t.sub(':00', '')} #{zone}"
  end

  def format_datetime(start_time, end_time=nil)
    t = format_time(start_time)
    t += " - #{format_time(end_time)}" if end_time
    t + " on #{format_date(start_time)}"
  end
end
