class SocialAuthenticationsController < ApplicationController
  def create_by_facebook
    @social_auth = SocialAuthentication.where(:provider => params[:provider],:uid => params[:id])
    @user = User.where(:email => params[:email])

    if @user.blank? and @social_auth.blank?
      generated_password = Devise.friendly_token.first(10)
      @user = User.create!(:email => params[:email],:first_name => params[:first_name],
                       :last_name => params[:last_name],
                       :password => generated_password)
      if !@user.nil?
        @user.social_authentications.create(:provider => params[:provider],:uid => params[:id],
        :user_name => params[:first_name])
        
        sign_in(:user, @user)
        status = true   
      else
        flash[:notice] = "Error in Creating a User Please Try Again"
        status = false        
      end     
    else
      if @user.blank?
        generated_password = Devise.friendly_token.first(10)
        @user = User.create!(:email => params[:email],:first_name => params[:first_name],
                       :last_name => params[:last_name],
                       :password => generated_password)
         if @user.save
          @user.social_authentications.create(:provider => params[:provider],:uid => params[:id],
          :user_name => params[:first_name])
          
          sign_in(:user, @user)
          status = true   
        else
          flash[:notice] = "Error in Creating a User Please Try Again"
          status = false        
        end
      else
        if @social_auth.blank?
          SocialAuthentication.create(:provider => params[:provider],:uid => params[:id],
                               :user_name => params[:first_name],:user_id => @user.first.id)
        end        
        
        sign_in(:user, @user.first)
        status = true
      end     
    end

    respond_to do |format|
      format.json { render :json => status }
    end
  end

  def create_by_linkedin
    @social_auth = SocialAuthentication.find_by_provider_and_uid(params[:provider], params[:id])

    if !@social_auth.nil?
      flash[:notice] = "Signed In With #{params[:provider].camelize} Successfully"
      sign_in(@social_auth.user)
    else
      @user = User.find_by_email(params[:email])
      if @user.nil?
        
        generated_password = Devise.friendly_token.first(10)
        @user = User.create!(:email => "#{params[:first_name]}@#{params[:provider]}.com",:first_name => params[:first_name],
        :last_name => params[:last_name], :password => generated_password)

        if @user.save
          @user.social_authentications.create(:provider => params[:provider],:uid => params[:id],:user_name => params[:first_name])
          sign_in(@user)
          flash[:notice] = "Signed In With #{params[:provider].camelize} Successfully"
        status = true
        else
          flash[:notice] = "Error in Creating a User Please Try Again"
          sign_in(@user)
        status = false
        end
      else
        @user.social_authentications.create(:provider => params[:provider],:uid => params[:id],:user_name => params[:first_name])
        flash[:notice] = "Signed In With #{params[:provider].camelize} Successfully"
        sign_in(@user)
      status = true
      end
    end

    respond_to do |format|
      format.json { render :json => status }
    end
  end

end
