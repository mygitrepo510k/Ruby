class ApplicantsController < ApplicationController
  # GET /applicants
  # GET /applicants.json
  def index
    @applicants = Applicant.all

    render json: @applicants
  end

  # GET /applicants/1
  # GET /applicants/1.json
  def show
    @applicant = Applicant.find(params[:id])

    render json: @applicant
  end

  # GET /applicants/new
  # GET /applicants/new.json
  def new
    @applicant = Applicant.new

    render json: @applicant
  end

  # POST /applicants
  # POST /applicants.json
  def create
    @applicant = Applicant.new(params[:applicant])

    if @applicant.save
      render json: @applicant, status: :created, location: @applicant
    else
      render json: @applicant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /applicants/1
  # PATCH/PUT /applicants/1.json
  def update
    @applicant = Applicant.find(params[:id])

    if @applicant.update_attributes(params[:applicant])
      head :no_content
    else
      render json: @applicant.errors, status: :unprocessable_entity
    end
  end

  # DELETE /applicants/1
  # DELETE /applicants/1.json
  def destroy
    @applicant = Applicant.find(params[:id])
    @applicant.destroy

    head :no_content
  end
end
