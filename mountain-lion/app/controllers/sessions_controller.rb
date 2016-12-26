class SessionsController < ApplicationController
  force_ssl if: :production?
  skip_filter :require_login, except: [:destroy]
  layout "frontpage"
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:username_or_email],params[:password],params[:remember])
      if @user.is_a? Admin
        redirect_to admin_root_path, notice: I18n.t('controllers.sessions.create.success')
      else
        unless @user.blocked
          session[:logged_in] = true
          unless @user.active
            @user.update_attribute(:active, true)
          end
          if !@user.required_user_fields_complete?
            redirect_back_or_to(mandatory_edit_profile_user_path(@user), notice: I18n.t('controllers.sessions.create.success'))
          else
            redirect_back_or_to(users_path, notice: I18n.t('controllers.sessions.create.success'))
          end
        else
          logout
          redirect_to(root_url, notice: 'This account has been Suspended until further notice')
        end
      end
    else
      flash.now[:error] = I18n.t('controllers.sessions.create.failure')
      render action: "new"
    end
  rescue
    flash.now[:error] = I18n.t('controllers.sessions.create.failure')
    render action: "new"
  end
  def destroy
    logout
    redirect_to(root_url, notice: I18n.t('controllers.sessions.destroy.success'))
  end
end
