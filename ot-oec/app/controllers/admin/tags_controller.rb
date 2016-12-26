class Admin::TagsController < ApplicationController
  def index
    @tags = Tag.all.paginate page: params[:page]      
  end
  
  def new
    @tag = Tag.new
  end

  def create    
    @tag = Tag.new
    @tag.name = params[:tag][:name]
    @tag.tag_type = params[:tag][:tag_type]
    @tag.added_by_id = current_user.id
    
    respond_to do |format|      
      if @tag.save
        format.html { redirect_to action: :index}
        format.json { render json: @tag, status: :created, location: @tag }
        flash[:notice] ='Tag was successfully created.' 
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tag = Tag.find(params[:id])
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    @tag.name = params[:tag][:name]
    @tag.tag_type = params[:tag][:tag_type]
    @tag.added_by_id = current_user.id
    
    respond_to do |format|      
      if @tag.save
        format.html { redirect_to action: :index}
        format.json { render json: @tag, status: :created, location: @tag }
        flash[:notice] ='Tag was successfully updated.' 
      else        
        format.html { render action: :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to action: :index
    end
  end

end
