class ChallengeFramesController < ApplicationController
	before_filter :require_login

	def show
		common_layout_support
		@frame = ChallengeFrame.find(params[:id])
	end

	def new
		c = Challenge.find(params[:challenge])
		frame = ChallengeFrame.create!(challenge: c, user: current_user)
		redirect_to frame
	end

	def judge
		frame = ChallengeFrame.find(params[:id])
		if params[:vote] == 'approve'
			frame.update!(approved_by: current_user, approved_at: DateTime.now)
		elsif params[:vote] == 'again'
			frame.update!(again_by: current_user, again_at: DateTime.now)
		elsif params[:vote] == 'clear'
			frame.update!(approved_by: nil, approved_at: nil, again_by: nil, again_at: nil)
		end
		redirect_to frame
	end
end
