class CommentsController < ApplicationController
	before_filter :require_login
  respond_to :json

  def create
    comment = Comment.create(params[:comment].merge(by: current_user))
    html = render_to_string(
      template: '/comments/_comment.slim', 
      formats: ['html'], layout: false,
      locals: { comment: comment } )

    if comment.commentable.class == Post
      post = comment.commentable
      post.update_attribute(:bumped, Time.now)
      UserMailer.commented_on_your_post(post, comment).deliver
      
      # - Disabling this case - don't think we need it
      #post.comments.each do |cmt|
      #  UserMailer.commented_on_your_comment(cmt.by, post, comment).deliver
      #end

    #elsif comment.commentable.class == Challenge
    #  challenge = comment.commentable
    #  UserMailer.commented_on_your_challenge(challenge, comment).deliver

    elsif comment.commentable.class == Experience
      experience = comment.commentable
      if comment.scope == 'admin'
        experience.followers.each do |u|          
          UserMailer.note_to_following_experience(u, experience, comment).deliver
        end
      else
        if experience.executed_at
          UserMailer.commented_on_your_experience(experience, comment).deliver
        end
      end
    elsif comment.commentable.class == User
      unless comment.scope == 'admin'
        user = comment.commentable
        UserMailer.commented_on_your_profile(user, comment).deliver
      end
    end
    
    render json: { html: html, count: comment.commentable.comments.count }
  end

  def new
  end

  def update
  end

	def destroy
    comment = Comment.find(params[:id])
    unless current_user.admin? or comment.by == current_user
			render json: { message: 'You are not allowed to delete this comment' }, status: :unauthorized and return
    else
      render json: { status: comment.delete }
    end
	end
end
