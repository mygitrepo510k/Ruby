class Admin::EventsController < ApplicationController
	layout 'admin'
	before_filter :authenticate_admin

	def index
		@events = Event.all.paginate(page: params[:page], :per_page => 10)
		respond_to do |format|
			format.html
			format.json { render json: @events }
		end
	end

	def show
		@event = Event.find(params[:id])
		respond_to do |format|
			format.html
			format.json { render json: @event}
		end
	end

end