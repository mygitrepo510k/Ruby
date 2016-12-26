class ScoutListingsController < ApplicationController
  # GET /scout_listings
  # GET /scout_listings.json
  def index
    @scout_listings = ScoutListing.all

    render json: @scout_listings
  end

  # GET /scout_listings/1
  # GET /scout_listings/1.json
  def show
    @scout_listing = ScoutListing.find(params[:id])

    render json: @scout_listing
  end

  # GET /scout_listings/new
  # GET /scout_listings/new.json
  def new
    @scout_listing = ScoutListing.new

    render json: @scout_listing
  end

  # POST /scout_listings
  # POST /scout_listings.json
  def create
    @scout_listing = ScoutListing.new(params[:scout_listing])

    if @scout_listing.save
      render json: @scout_listing, status: :created, location: @scout_listing
    else
      render json: @scout_listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /scout_listings/1
  # PATCH/PUT /scout_listings/1.json
  def update
    @scout_listing = ScoutListing.find(params[:id])

    if @scout_listing.update_attributes(params[:scout_listing])
      head :no_content
    else
      render json: @scout_listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /scout_listings/1
  # DELETE /scout_listings/1.json
  def destroy
    @scout_listing = ScoutListing.find(params[:id])
    @scout_listing.destroy

    head :no_content
  end
end
