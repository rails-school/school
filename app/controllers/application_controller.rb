require_dependency "user_sanitizer"

class ApplicationController < ActionController::Base
  before_filter :set_time_zone, :maybe_enqueue_badge_allocator, :maybe_enqueue_codewars_recorder

  protect_from_forgery
  helper_method :current_school

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def current_school
    unless @current_school
      if params[:school]
        @current_school = School.find_by_slug(params[:school])
      elsif session[:school]
        @current_school = School.find_by_slug(session[:school])
      elsif current_user
        @current_school = current_user.school
      end
    end

    unless @current_school
      if @lesson
        @current_school = @lesson.venue.school
      end
    end

    unless @current_school
      begin
        loc = request.location
        @current_school = Venue.near([loc.latitude, loc.longitude], 5000)
                               .first
                               .school
      rescue StandardError
      end
    end

    unless @current_school
      @current_school = Venue.order("created_at").first.school
    end

    binding.pry unless @current_school
    session[:school] = @current_school.slug
    @current_school
  end

  def set_time_zone
    Time.zone = current_school.timezone
  end

  def devise_parameter_sanitizer
    if resource_class == User
      User::ParameterSanitizer.new(User, :user, params)
    else
      super
    end
  end

  private
  def maybe_enqueue_badge_allocator
    return unless user_signed_in?
    if current_user.last_badges_checked_at.nil? ||
       (Time.now - current_user.last_badges_checked_at > 3600)
      BadgeAllocator.perform_async(current_user.id)
      current_user.last_badges_checked_at = Time.now
      current_user.save!
    end
  end

  def maybe_enqueue_codewars_recorder
    return unless user_signed_in?
    return unless current_user.teacher?
    # Below: Checks codewars completed for the teacher.
    enqueue_codewars_recorder(current_user)
    # Below: Checks the codewars completed for each of the students of this teacher's upcoming lessons (in next 1 week).
    upcoming_lessons_for_teacher = Lesson.includes(:users)
                         .where("start_time > ? AND start_time < ? AND teacher_id = ?", Time.current, Time.current + 1.week, current_user.id)
    if upcoming_lessons_for_teacher.present?
      upcoming_lessons_for_teacher.each do |lesson|
        if lesson.codewars_challenge_slug.present?
          lesson.users.each do |student|
            enqueue_codewars_recorder(student)
          end
        end
      end
    end
  end

  def enqueue_codewars_recorder(student)
    return unless student.codewars_username.present?
    if student.last_codewars_checked_at.nil? ||
        (Time.now - student.last_codewars_checked_at > 3600)
      CodewarsRecorder.perform_async(student.id, student.codewars_username)
      student.last_codewars_checked_at = Time.now
      student.save!
    end
  end
end
