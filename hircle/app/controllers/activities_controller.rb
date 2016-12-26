class ActivitiesController < ApplicationController
  # GET /activities
  # GET /activities.json
  def index
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @activities }
    end
  end

  # GET /activities/1
  # GET /activities/1.json
  def show
    @activity = Activity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/new
  # GET /activities/new.json
  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @activity }
    end
  end

  # GET /activities/1/edit
  def edit
    @activity = Activity.find(params[:id])
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render json: @activity, status: :created, location: @activity }
      else
        format.html { render action: "new" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /activities/1
  # PUT /activities/1.json
  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  # GET /activities/comments
  # GET /activities/comments.json
  
  def comments     
     comments=Comment.includes(:comments,:user).where("activity_id=? and parent_id is NULL",params[:id])    
     @comment_views=buildCommentView(comments)
      respond_to do |format|
      #format.html 
      format.json { render json: @comment_views }
      end
  end
  #recursive to get comments
  private
  def buildCommentView(comments)
     comment_views=[]
      comments.each do |comment|
          #new view and sons of comment
          commentview=ProtocolJsonHelper::CommentView.new
          commentview.comment_id=comment.id
          commentview.activity_id=comment.activity_id
          creator=comment.user          
          commentview.user_id=creator.id
          commentview.name=creator.full_name     
          commentview.thumbnail=creator.avatar.url(:thumb)
          #time short
          commentview.time_short=((Time.now - comment.create_at) /(1*60*60)).to_i.to_s+' hours ago' 
          commentview.content=comment.content
          commentview.replys=buildCommentView(comment.comments)         
          comment_views << commentview                
      end
      return comment_views
  end
  
end
