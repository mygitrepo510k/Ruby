class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
	before_filter :require_login
  respond_to :json, only: [:create]

  def create
    like = Like.toggle(params.slice(:likeable_id, :likeable_type).merge({by_id: current_user.id}))
    render json: { count: like.likeable.likes.count, link: like.destroyed? ? 'Like' : 'Unlike' }
  end
end
