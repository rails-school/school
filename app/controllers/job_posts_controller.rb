class JobPostsController < ApplicationController
  before_filter :fix_dates, only: [:create, :update]
  load_and_authorize_resource except: [:index]

  def index
    if current_school.present?
      @job_posts = JobPost.where(school: current_school)
                   .active.order("ends_at ASC")
      @title = "All jobs for #{current_school.name}"
    else
      @job_posts = JobPost.active.order("ends_at ASC")
      @title = "All job listings"
    end

    respond_to do |format|
      format.html
      format.json { render json: @job_posts }
    end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @job_post.save
        format.html { redirect_to @job_post,
                      notice: 'Job post was successfully created.' }
        format.json { render json: @job_post, status: :created,
                             location: @job_post }
      else
        format.html { render action: "new" }
        format.json { render json: @job_post.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_post.update_attributes(job_post_params)
        format.html { redirect_to @job_post,
                      notice: 'Job post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job_post.errors,
                             status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to job_posts_url }
      format.json { head :no_content }
    end
  end


private

  def job_post_params
    params.require(:job_post).permit(
      :starts_at, :ends_at, :title, :description, :school_id, :url
    )
  end

  def fix_dates
    jp_params = params[:job_post]
    if jp_params
      Time.zone = School.find(jp_params[:school_id]).timezone
      jp_params[:starts_at] = Time.zone.parse("#{jp_params[:starts_at]} 00:00")
      jp_params[:ends_at] = Time.zone.parse("#{jp_params[:ends_at]} 23:59")
    end
  end
end
