class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.json
  def index
    @places = Venue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @places }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @place = Venue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @place }
    end
  end

  # GET /venues/new
  # GET /venues/new.json
  def new
    @place = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @place }
    end
  end

  # GET /venues/1/edit
  def edit
    @place = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.json
  def create
    @place = Venue.new(params[:venue])

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Venue.was successfully created.' }
        format.json { render json: @place, status: :created, location: @place }
      else
        format.html { render action: "new" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.json
  def update
    @place = Venue.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(venue_params)
        format.html { redirect_to @place, notice: 'Venue.was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @place = Venue.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :no_content }
    end
  end

  private
  def venue_params
    params.require(:venue).permit(
      :address, :city, :country, :state, :zip, :name, :slug, :comment
    )
  end
end
