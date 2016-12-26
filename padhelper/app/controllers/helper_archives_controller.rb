class HelperArchivesController < ApplicationController
  # GET /helper_archives
  # GET /helper_archives.json
  def index
    @helper_archives = HelperArchive.all

    render json: @helper_archives
  end

  # GET /helper_archives/1
  # GET /helper_archives/1.json
  def show
    @helper_archive = HelperArchive.find(params[:id])

    render json: @helper_archive
  end

  # GET /helper_archives/new
  # GET /helper_archives/new.json
  def new
    @helper_archive = HelperArchive.new

    render json: @helper_archive
  end

  # POST /helper_archives
  # POST /helper_archives.json
  def create
    @helper_archive = HelperArchive.new(params[:helper_archive])

    if @helper_archive.save
      render json: @helper_archive, status: :created, location: @helper_archive
    else
      render json: @helper_archive.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /helper_archives/1
  # PATCH/PUT /helper_archives/1.json
  def update
    @helper_archive = HelperArchive.find(params[:id])

    if @helper_archive.update_attributes(params[:helper_archive])
      head :no_content
    else
      render json: @helper_archive.errors, status: :unprocessable_entity
    end
  end

  # DELETE /helper_archives/1
  # DELETE /helper_archives/1.json
  def destroy
    @helper_archive = HelperArchive.find(params[:id])
    @helper_archive.destroy

    head :no_content
  end
end
