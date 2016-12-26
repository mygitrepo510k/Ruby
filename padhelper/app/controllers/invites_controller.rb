class InvitesController < ApplicationController
  # GET /invites
  # GET /invites.json
  def index
    @invites = Invite.all

    render json: @invites
  end

  # GET /invites/1
  # GET /invites/1.json
  def show
    @invite = Invite.find(params[:id])

    render json: @invite
  end

  # GET /invites/new
  # GET /invites/new.json
  def new
    @invite = Invite.new

    render json: @invite
  end

  # POST /invites
  # POST /invites.json
  def create
    @invite = Invite.new(params[:invite])

    if @invite.save
      render json: @invite, status: :created, location: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invites/1
  # PATCH/PUT /invites/1.json
  def update
    @invite = Invite.find(params[:id])

    if @invite.update_attributes(params[:invite])
      head :no_content
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invites/1
  # DELETE /invites/1.json
  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    head :no_content
  end
end
