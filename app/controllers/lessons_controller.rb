class LessonsController < ApplicationController
  before_filter :fix_dates, only: [:create, :update]
  before_filter :convert_slug_to_id
  load_and_authorize_resource except: [:index, :future_lessons_slug, :upcoming,
                                       :attending_lesson]
  before_action :authenticate_user!, only: [:attending_lesson]

  # GET /lessons
  # GET /lessons.json
  def index
    if params[:school].present?
      @lessons = Lesson.for_school_id(current_school.id)
                   .order("start_time DESC")
      @title = "All lessons in #{current_school.name}"
    else
      @lessons = Lesson.order("start_time DESC")
      @title = "All lessons, globally"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
      format.xml { render xml: @lessons }
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @whiteboard = params[:whiteboard]
    if @whiteboard
      authenticate_user!
      if Time.now > @lesson.start_time-10.minutes && Time.now < @lesson.end_time
        rsvp = current_user.attendances.where(lesson_id: @lesson.id).first
        rsvp.update_attribute(:confirmed, true) if rsvp && !rsvp.confirmed 
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json {
        render json: @lesson.to_json(
          students: @lesson.attendances.map(&:user)
        )
      }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    # @lesson = Lesson.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson.venue_id = 1 if @lesson.venue_id.blank?
    @lesson.teacher = current_user
    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson was successfully created.' }
        format.json { render json: @lesson, status: :created, location: @lesson }
      else
        format.html { render action: "new" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update_attributes(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url }
      format.json { head :no_content }
    end
  end

  # GET /l/future/slugs.json
  def future_lessons_slug
    future_lessons = Lesson.future_lessons
    if params[:school_id].present?
      future_lessons = future_lessons.for_school_id(params[:school_id])
    end
    render json: future_lessons.pluck(:slug)
  end

  # GET /l/upcoming.json
  def upcoming
    next_lessons = Lesson.future_lessons
    if params[:school_id].present?
      next_lessons = next_lessons.for_school_id(params[:school_id])
    end
    render json: next_lessons.first
  end

  # GET /attending_lesson/:lesson_slug.json
  def attending_lesson
    lesson = Lesson.find_by(slug: params[:lesson_slug])
    attendance = current_user.attendances.find_by(lesson_id: lesson.id)
    render json: !attendance.nil?
  end

private
  def convert_slug_to_id
    if id_is_slug?(params[:id])
      l = Lesson.find_by_slug(params[:id])
      params[:id] = l.id if l.present?
    end
  end

  def id_is_slug?(id)
    id && !(id.to_i > 0 && id.to_i.to_s == id)
  end

  def fix_dates
    l_params = params[:lesson]
    if l_params
      Time.zone = Venue.find(l_params[:venue_id]).school.timezone
      date = l_params.delete("date")
      l_params[:start_time] =
        Time.zone.parse("#{date} #{l_params[:start_time]}")
      l_params[:end_time] =
        Time.zone.parse("#{date} #{l_params[:end_time]}")
    end
  end

  def lesson_params
    params.require(:lesson).permit(
      :archive_url, :codewars_challenge_language, :codewars_challenge_slug,
      :description, :end_time, :hangout_url, :image_social, :slug, :start_time,
      :summary, :title, :tweet_message, :venue_id
    )
  end
end
