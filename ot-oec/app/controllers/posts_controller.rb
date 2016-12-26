class PostsController < ApplicationController
	before_filter :require_login
	before_filter :common_layout_support, only: :show
	respond_to :json, only: [:create, :destroy, :update]

	def index
	end

	def new
	end

	def create
		@post = Post.create(params[:post].merge(by: current_user, program: current_user.current_program))
    # also disabling this case for now
		#User.created_new_blog(@post)
		html = render_to_string(
			template: '/dashboard/_post.slim', 
			formats: ['html'], layout: false,
			locals: { post: @post, feed: true } )
		render json: { html: html }
	end

	def search
    @results = Post.search_posts_and_comments(current_user, params[:query])
  end

  def show
		@post = Post.find(params[:id])
  end

	def edit
	end

	def update
		post = Post.find(params[:id])
    unless current_user.admin? or post.by == current_user
			render json: { message: 'You are not allowed to delete this post' }, status: :unauthorized and return
    else
      post.body = params[:post][:body]
      render json: { success: post.save, body: post.body }
    end
	end

	def destroy
    post = Post.find(params[:id])
    unless current_user.admin? or post.by == current_user
			render json: { message: 'You are not allowed to delete this post' }, status: :unauthorized and return
    else
      post.delete
      render json: { status: post.deleted }
    end
	end
end
