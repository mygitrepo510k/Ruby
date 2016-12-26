class ArtistsController < ApplicationController
	#before_filter :authenticate_admin!
	before_filter :find_or_build_artist, :except => :index
	respond_to :html, :json, :js

  # GET /artists
  # GET /artists.json
  def index
		redirect_to browse_path
# 	  if params[:query].present?
# 		  query = params[:query].downcase
# 			@artists = Artist.search(_keywords: query)
# 	  elsif params[:category].blank? and params[:filter].present?
# 	    @artists = Artist.w(starting_with: params[:filter])
#     elsif params[:query].blank? and params[:category].blank? and params[:filter].blank?
#     	@artists = Artist.where(starting_with: 'A')
#     else
# 	  	 @artists = []
# 	  end
# 
#     respond_to do |format|
#       format.html # index.html.erb
#       format.json { render json: @artists }
#     end
  end

  # GET /artists/1
  # GET /artists/1.json
  def show
    respond_with @artist = Artist.find(params[:id])

#     respond_to do |format|
#       format.html # show.html.erb
#       format.json { render json: @artist }
#     end
  end

  # GET /artists/new
  # GET /artists/new.json
  def new
    @artist = Artist.new
    @artist.build_upload
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @artist }
    end
  end

  # GET /artists/1/edit
  def edit
    @artist = Artist.find(params[:id])
    @artist.build_upload if @artist.upload.nil?
  end

  # POST /artists
  # POST /artists.json
  def create
    @artist = Artist.new(params[:artist])
    @matching_artist = Artist.where(name: @artist.name).and(category: @artist.category).first
		
		unless @matching_artist.present?
      if @artist.save
        format.html {
          render :json => [@artist.to_jq_upload].to_json, :content_type => 'text/html', :layout => false 
        }
        format.json { render json: [@artist.to_jq_upload].to_json, status: :created, location: @artist }
      else
        render action: "new"
      end
    else
    	flash[:notice]= 'Artist already exists in this category'
    	render action: "new"
    end
  end

  # PUT /artists/1
  # PUT /artists/1.json
  def update
    @artist = Artist.find(params[:id])

    if @artist.update_attributes!(params[:artist])
      flash[:notice]= 'Artist was successfully updated.'
      redirect_to @artist
    else
      flash[:notice]= 'Artist already exists in this category'
      render action: "edit"
    end
  end

  # DELETE /artists/1
  # DELETE /artists/1.json
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    respond_to do |format|
      format.html { redirect_to (request.referer || artists_path) }
      format.json { head :ok }
    end
  end

private
  def find_or_build_artist
    @artist = params[:id] ? Artist.find(params[:id]) : Artist.new(params[:artist])
  end

end
