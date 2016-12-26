class SpacesUsersController < ApplicationController
  def new
     @spaces_users = SpacesUser.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @spaces_users }
    end
  end
  def index
    @spaces_users = SpacesUser.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @spaces_users }
    end
  end
  def show

    @spaces_users = SpacesUser.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @spaces_users }
    end
  end

  def destroy
  end

  def edit
    @spaces_users = SpacesUser.find(params[:id])
  end

  def create


    @uid = User.where( ["first_name like ? and last_name like ? ", "%#{params[:users][:first_name]}%","%#{params[:users][:last_name]}%"]).select ("id")
    @spid = Space.where([" name like ?'","%#{params[:spaces][:name]}%"]).select("id")
    
   
    @sp_usr = {:user_id => @uid,:space_id => @spid}

    @spaces_users = SpacesUser.new(:user_id => @uid.id,:space_id =>@spid.space_id)
       
    respond_to do |format|
      if @spaces_users.save
        format.html { redirect_to @spaces_users, notice: "Users have been added successfully to the space with user_id:  ***********" }
        format.json { render json: @spaces_users, status: :created, location: @spaces_users }
      else
        format.html { render action: "new" }
        format.json { render json: @spaces_users.errors, status: :unprocessable_entity }
      end
    end
  end

   def update
    @spaces_users = SpacesUser.find(params[:id])

    respond_to do |format|
      if @spaces_users.update_attributes(params[:spaces_users])
        format.html { redirect_to @spaces_users, notice: 'Space was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @spaces_users.errors, status: :unprocessable_entity }
      end
    end
  end


end
