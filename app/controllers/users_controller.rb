class UsersController < ApplicationController
  before_filter :admin_only, :except => :unsubscribe

  # GET /users
  # GET /users.json
  def unsubscribe

    code = params[:code]
    user = User.find_by_unsubscribe_token(code)
    user.subscribe = false
    user.save!

    render text: "you have been successfully unsubscribed from RailsSchool notifications. Thank you for all the good you have, cheers and astalavista."

  end

  def notify_subscribers
    if current_user.email.match(/.*@railsschool.org$/)
      lesson = Lesson.find(params[:id])
      users = User.where(:subscribe => true).to_a
      users << User.new(:name => "Starmonkeys", :email => "starmonkeys@googlegroups.com")
      users << User.new(:name => "Noisebridge", :email => "noisebridge-announce@lists.noisebridge.net")
      users.each do |u|
        NotificationMailer.lesson_notification(lesson, u, current_user).deliver
      end
    end
  end

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
