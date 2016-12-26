class RegistrationsController < Devise::RegistrationsController
  def new    
    invitation = Invitation.find_by_token(params[:invite_token])    
    if invitation.present?
      if invitation.state == Invitation::STATE[2]
        redirect_to root_path
        flash[:notice] = 'Your invitation was revoked by vendor' 
      else
        @user = User.new(email:invitation.recipient_email)
      end      
    else
      super
    end    
  end

  def create
    invitations = Invitation.pending_invitations.where(recipient_email:params[:user][:email])
    if invitations.present?
      vendor =invitations.last.sender.vendor
      @user = User.new(params[:user].permit(:email,:password,:password_confirmation))
      respond_to do |format|
        if @user.save
          vendor_user = @user.build_vendor_user(name:'vendor_user', vendor_id:vendor.id)
          if vendor_user.save
            invitations.each do |inv|
              inv.update_attribute(:state,Invitation::STATE[1])
            end
          end
          format.html { redirect_to root_path}
          flash[:notice] = 'User was successfully created.' 
          format.json { render json: @user, status: :created, location: @user }
        else
          format.html { redirect_to root_path}
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      super
    end
  end
end
