class VoiceoversController < ApplicationController
  before_filter :authenticate_admin!, except: [:index, :show]
  before_filter :find_artist, :except => [:index]
  before_filter :find_or_build_voiceover, :except => [:index, :sort]
	respond_to :html, :json, :js

  # GET /voiceovers
  # GET /voiceovers.json
  def index
		@voiceover = Voiceover.new
		if admin_signed_in?
			@list = current_admin.lists.build
		end
		
	  if params[:query].present?
		  query = params[:query].downcase
			@artists = Artist.search(_keywords: query)
	  elsif params[:category].present? and params[:filter].present?
	    @artists = Artist.where(category: params[:category]).and(starting_with: params[:filter])
	  elsif params[:category].blank? and params[:filter].present?
	    @artists = Artist.where(starting_with: params[:filter])
	  elsif params[:category].present? and params[:filter].blank?
	  	@artists = Artist.where(category: params[:category])
    elsif params[:query].blank? and params[:category].blank? and params[:filter].blank?
    	@artists = Artist.all
    else
	  	 @artists = []
	  end
		
# 		case params[:category] and params[:filter].blank?
# 		when "Commercial"
# 		  @artists = Artist.where(category: "Commercial").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Promo"
# 		  @artists = Artist.where(category: "Promo").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Narration/Documentary"
# 		  @artists = Artist.where(category: "Narration/Documentary").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Political"
# 		  @artists = Artist.where(category: "Political").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Trailer"
# 		  @artists = Artist.where(category: "Trailer").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Animation"
# 		  @artists = Artist.where(category: "Animation").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Books on Tape"
# 		  @artists = Artist.where(category: "Books on Tape").sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		when "Latest"
# 		  @artists = Artist.where(:created_at.lte => 1.month.from_now).sort_by {|a| a.starting_with}.take_while{|a| a.starting_with == 'A'}
# 		end
  end

  # GET /voiceovers/1
  # GET /voiceovers/1.json
  def show
		send_file @voiceover.voiceover.path
  end

  # GET /voiceovers/new
  # GET /voiceovers/new.json
  def new
  end

  # GET /voiceovers/1/edit
  def edit
  end

  # POST /voiceovers
  # POST /voiceovers.json
  def create
    respond_to do |format|
      if @voiceover.save
        format.html { redirect_to artist_path(@artist), notice: 'Voiceover was successfully uploaded.' }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  # PUT /voiceovers/1
  # PUT /voiceovers/1.json
  def update
    respond_to do |format|
      if @voiceover.update_attributes(params[:voiceover])
        format.html { redirect_to [@artist, @voiceover], notice: 'Voiceover was successfully updated.' }
        format.js
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end

  # DELETE /voiceovers/1
  # DELETE /voiceovers/1.json
  def destroy
    @voiceover.destroy
    redirect_to @artist
  end

  def sort
    # params[:photo] is an array of photo IDs in the order
    # the should be set in the story. Take each ID and it's
    # index in the array, find the photo with the ID and set
    # it's position to the index. Run through the whole ID 
    # array. Mongoid will automatically do an atomic update
    # of only the photos whose position has changed.
    params[:voiceover].each_with_index do |id, idx|
      @artist.voiceovers.find(id).position = idx
    end
    @artist.save
    render :nothing => true
  end

private
  def find_artist
    @artist = Artist.find(params[:artist_id])
  end

  def find_or_build_voiceover
    @voiceover = params[:id] ? @artist.voiceovers.find(params[:id]) : @artist.voiceovers.build(params[:voiceover])
  end

end
