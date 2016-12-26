class AdministratorController < ApplicationController
  before_filter :authenticate_user!,:except=>["add_user","create_user"]
  def index
  end

  def add_user
    @invitation = Invitation.find params[:id]
    @user = User.new
  end

  def create_user
    @user = User.create(params[:user])
    respond_to do |format|
      if @user
        format.html { redirect_to :action=>"index", notice: 'Invitation was successfully created.' }
        format.json { render json: @invitation, status: :created, location: @invitation }
      else
        format.html { render action: "index" }
        format.json { render json: @invitation.errors, status: :unprocessable_entity }
      end
    end
  end
end
