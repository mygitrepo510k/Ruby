class Admin::ContentsController < ApplicationController
	before_filter :require_admin

	def index
		@contents = Content.all.paginate page: params[:page]
	end

  def new
  	@content = Content.new
  end

  def create
  	@content = Content.new(params[:content])
    @content.program = current_user.current_program
  	@content.created_by = current_user
  	respond_to do |format|
      if @content.save
        ContentTag.create(content_id:@content.id,tag_id:params[:content][:time_tag])
        ContentTag.create(content_id:@content.id,tag_id:params[:content][:category_tag])
        format.html { redirect_to [:admin, @content], notice: 'Content was successfully created.' }
        format.json { render json: @content, status: :created, location: @content }
      else
        format.html { render action: "new" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  	@content = Content.find(params[:id])
  end

  def update
  	@content = Content.find(params[:id])  	
  	respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to [:admin, @content], notice: 'Content was successfully updated.' }
        format.json { render json: @content, status: :created, location: @content }
      else
        format.html { render action: "new" }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end  	
  end
  def show
  	@content = Content.find(params[:id])
  end
  def destroy
  	@content = Content.find(params[:id])
  	@content.destroy if @content.present?
  	redirect_to action: :index
  end
end
