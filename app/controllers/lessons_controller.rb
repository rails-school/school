class LessonsController < ApplicationController
  around_filter :school_timezone, only: [:create, :update]
  before_filter :fix_dates, only: [:create, :update]
  before_filter :convert_slug_to_id
  load_and_authorize_resource except: [:index]

  # GET /lessons
  # GET /lessons.json
  def index
    if params[:school].present?
      @lessons = Lesson.for_school(current_school).order("start_time DESC")
      @title = "All lessons in #{current_school.name}"
    else
      @lessons = Lesson.order("start_time DESC")
      @title = "All lessons, globally"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
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
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/new
  # GET /lessons/new.json
  def new
    # @lesson = Lesson.new
    @venues = current_school.venues

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lesson }
    end
  end

  # GET /lessons/1/edit
  def edit
    @venues = current_school.venues
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
      if @lesson.update_attributes(params[:lesson])
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

private
  def convert_slug_to_id
    if (params[:id] && !(params[:id].to_i > 0))
      l = Lesson.find_by_slug(params[:id])
      params[:id] = l.id if l.present?
    end
  end

  def school_timezone(&block)
    l_params = params[:lesson]
    if l_params
      Time.use_zone(Venue.find(l_params[:venue_id]).school.timezone, &block)
    end
  end

  def fix_dates
    l_params = params[:lesson]
    if l_params
      date = l_params.delete("date")
      l_params[:start_time] =
        Time.zone.parse("#{date} #{l_params[:start_time]}")
      l_params[:end_time] =
        Time.zone.parse("#{date} #{l_params[:end_time]}")
    end
  end
end
