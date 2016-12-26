class Admin::EventsController < ApplicationController
  before_filter :require_admin

  def index
    @events = Event.where(program: current_user.current_program).paginate page: params[:page]
  end

  def create
    @event = Event.new()
    @event.name = params[:event][:name]
    @event.description = params[:event][:description]
    @event.place_name = params[:event][:place_name]
    @event.start = DateTime.strptime(params[:event][:start], "%m/%d/%Y %H:%M")
    @event.end = DateTime.strptime(params[:event][:end], "%m/%d/%Y %H:%M")
    @event.created_by_id = current_user.id
    @event.program = current_user.current_program
    respond_to do |format|
      if @event.save
        User.created_new_event(@event)
        format.html { redirect_to [:admin, @event], notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.name = params[:event][:name]
    @event.description = params[:event][:description]
    @event.place_name = params[:event][:place_name]

    @event.start = DateTime.strptime(params[:event][:start], "%m/%d/%Y %H:%M")
    @event.end = DateTime.strptime(params[:event][:end], "%m/%d/%Y %H:%M")
    @event.created_by_id = current_user.id

    respond_to do |format|
      if @event.save
        format.html { redirect_to [:admin, @event], notice: 'Event was successfully update.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event = Event.find(params[:id])    
    @event.destroy
    redirect_to action: :index
  end
end
