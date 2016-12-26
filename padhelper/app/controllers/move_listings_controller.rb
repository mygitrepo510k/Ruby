class MoveListingsController < ApplicationController
  # GET /move_listings
  # GET /move_listings.json
  def index
    @move_listings = MoveListing.all

    render json: @move_listings
  end

  # GET /move_listings/1
  # GET /move_listings/1.json
  def show
    @move_listing = MoveListing.find(params[:id])

    render json: @move_listing
  end

  # GET /move_listings/new
  # GET /move_listings/new.json
  def new
    @move_listing = MoveListing.new

    render json: @move_listing
  end

  # POST /move_listings
  # POST /move_listings.json
  def create
    @move_listing = MoveListing.new(params[:move_listing])

    if @move_listing.save
      render json: @move_listing, status: :created, location: @move_listing
    else
      render json: @move_listing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /move_listings/1
  # PATCH/PUT /move_listings/1.json
  def update
    @move_listing = MoveListing.find(params[:id])

    if @move_listing.update_attributes(params[:move_listing])
      head :no_content
    else
      render json: @move_listing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /move_listings/1
  # DELETE /move_listings/1.json
  def destroy
    @move_listing = MoveListing.find(params[:id])
    @move_listing.destroy

    head :no_content
  end
end
