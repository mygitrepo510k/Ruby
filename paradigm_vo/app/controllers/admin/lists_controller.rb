class Admin::ListsController < ApplicationController
	before_filter :authenticate_admin!, except: [:show]
	respond_to :html, :json, :js

  # GET /lists
  # GET /lists.json
  def index
    @lists = current_admin.lists.all.desc(:updated_at)


  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])

# 		Voiceover.find(@list.voice_ids).each do |voice|
# 			@voice_ids = []
# 			
# 			unless @voice_ids.include?(Artist.find(voice.artist_id).id)
# 				@voice_ids << Artist.find(voice.artist_id).id
# 			end
# 		end

    respond_to do |format|
      format.html # show.html.erb
      format.js { render '_list' }
    end 
  end

  # GET /lists/new
  def new
    if session[:list_params]
		  session[:list_params].deep_merge!(params[:list]) if params[:list]
			@list = current_admin.lists.build(session[:list_params])
	  end

    respond_with(@list)
  end

  # GET /lists/1/edit
  def edit
    @list = current_admin.lists.find(params[:id])
    respond_with(@list)
  end

  # POST /lists
  # POST /lists.json
  def create
    session[:list_params] ||= {}
    
    if session[:list_params]
		  session[:list_params].deep_merge!(params[:list]) if params[:list]
			@list = current_admin.lists.build(session[:list_params])
	  end

    if params[:commit] == "Change My Selection"
    	session[:list_params] = nil
    	return false
		elsif params[:commit] == "Add Selection To List"
#     	if @list.new_record?
#     		redirect_back_or_default root_path
#     		flash[:error]= 'Whoops. You tried to add voices to a list that was not yet saved.'
#     	end
    	session[:list_params] ||= {}
    	@list = current_admin.lists.build(session[:list_params])
#     	session[:list_params]= nil
		elsif params[:commit] == "New List"
	    if @list.save
# 		    session[:list_params]= nil
		    respond_with(@list, location: admin_list_url(@list))
			else
				js_redirect_to(root_url)
	    end
		end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
		@list = current_admin.lists.find(params[:id])
		session[:list_params] ||= {}

    respond_to do |format|
			format.js do
				if params[:commit] ==  'Send Message'
					if @list.update_attributes(params[:list])
						VoiceMailer.send_voice_list(current_admin, @list).deliver
						flash[:notice]= 'This list was successfully sent out.'
						js_redirect_to	admin_list_path(@list)
					else
						flash[:notice]= 'This list was not sent out due to an error.'
						js_redirect_to	admin_list_path(@list)			
					end
				else
			    if session[:list_params]
					  session[:list_params].deep_merge!(params[:list]) if params[:list]
		
						for list in params[:admin][:lists]
				      @list = current_admin.lists.find(list)
				      @voices = @list.voice_ids ||= []
				      for voice in session[:list_params]['voice_ids']
					      @voices.push(voice) unless @voices.include?(voice)
					    end
					    
							if @list.update_attributes(params[:list])
								flash[:notice]= 'List was successfully updated.'									
				        session[:list_params]= nil
								js_redirect_to	admin_list_path(@list)
				      else
								flash[:notice]= 'List was not saved. Please try again.'
								js_redirect_to	admin_lists_path(@list)
				      end
						end
				  end		  
				end
	    end

			format.html do
		    @list = current_admin.lists.find(params[:id])
		    
		    if @list.update_attributes(params[:list])
		      redirect_to admin_lists_url, notice: 'List was successfully updated.'
		    else
		      render action: "edit"
		    end
		  end
		end		
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = current_admin.lists.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to admin_lists_url }
      format.json { head :ok }
    end
  end

end
