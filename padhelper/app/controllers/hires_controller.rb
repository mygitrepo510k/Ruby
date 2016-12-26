class HiresController < ApplicationController
  # GET /hires
  # GET /hires.json
  def index
    @hires = Hire.all

    render json: @hires
  end

  # GET /hires/1
  # GET /hires/1.json
  def show
    @hire = Hire.find(params[:id])

    render json: @hire
  end

  # GET /hires/new
  # GET /hires/new.json
  def new
    @hire = Hire.new

    render json: @hire
  end

  # POST /hires
  # POST /hires.json
  def create
    @hire = Hire.new(params[:hire])

    if @hire.save
      render json: @hire, status: :created, location: @hire
    else
      render json: @hire.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hires/1
  # PATCH/PUT /hires/1.json
  def update
    @hire = Hire.find(params[:id])

    if @hire.update_attributes(params[:hire])
      head :no_content
    else
      render json: @hire.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hires/1
  # DELETE /hires/1.json
  def destroy
    @hire = Hire.find(params[:id])
    @hire.destroy

    head :no_content
  end
end
