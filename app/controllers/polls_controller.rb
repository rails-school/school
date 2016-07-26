class PollsController < ApplicationController
  load_and_authorize_resource only: [:new, :create, :edit, :update, 
  :destroy, :published]
  before_action :authenticate_user!

  # GET /polls
  # GET /polls.json
  def index
    @polls = Poll.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @polls }
    end
  end

  # GET /polls/1
  # GET /polls/1.json
  def show
    @poll = Poll.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @poll }
    end
  end

  # GET /polls/new
  # GET /polls/new.json
  def new
      @poll = Poll.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @poll }

    end

  end

  # GET /polls/1/edit
  def edit
    @poll = Poll.find(params[:id])
  end

  # POST /polls
  # POST /polls.json
  def create

    @poll = Poll.new(poll_params)

    respond_to do |format|
      if @poll.save
        format.html { redirect_to edit_poll_path(@poll), notice: 'Poll was successfully created.' }
        format.json { render json: @poll, status: :created, location: @poll }
      else
        format.html { render action: "new" }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /polls/1
  # PUT /polls/1.json
  def update
    @poll = Poll.find(params[:id])

    respond_to do |format|
      if @poll.update_attributes(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy

    respond_to do |format|
      format.html { redirect_to polls_url }
      format.json { head :no_content }
    end
  end

  def answer
    answer_id = params[:answer][:id]
    poll_id = params[:answer][:poll_id]
    user_id = current_user.id
    ua = UserAnswer.new
    ua.answer_id = answer_id
    ua.user_id = user_id
    ua.poll_id = poll_id
    ua.save!
    @poll = Answer.find(answer_id).poll
  end

  private
  def poll_params
    params.require(:poll).permit(
      :question, :published
    )
  end
end
