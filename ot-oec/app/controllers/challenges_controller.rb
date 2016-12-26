class ChallengesController < ApplicationController
	before_filter :require_login

	def index
	end

	def show
		common_layout_support
		@challenge = Challenge.find(params[:id])
	end

	def create
	end

	def edit
	end

	def new
	end

	def update
	end
end
