ActiveAdmin.register User do
  
  index do
    column :id
    column :email
    default_actions           
  end

  form do |f|                         
    f.inputs "User Details" do
      if f.object.new_record?     
        f.input :email
      end
      if !f.object.new_record?
            f.input :password
            f.input :password_confirmation
      end
    end                               
    f.actions                         
  end

  controller do
    def show
      @user = User.find(params[:id])
      @versions = @user.versions 
      @user = @user.versions[params[:version].to_i].reify if params[:version]
      show! 
    end

  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @user = User.find(params[:id])
    @versions = @user.versions
    render "layouts/history"
  end

  member_action :lock, :method => :put do
    @user = User.find(params[:id])
    @user.lock_access!
    flash[:notice] = "#{@user.email} is now locked"
    redirect_to :action => :show
  end

  member_action :unlock, :method => :put do
    @user = User.find(params[:id])
    @user.unlock_access!
    flash[:notice] = "#{@user.email} is now unlocked"
    redirect_to :action => :show
  end


  action_item :only => :show do
    link_to('History', :action => "history")
  end

  action_item :only => :show do
    @user = User.find(params[:id])

    if @user.access_locked?
      link_to('Unlock', {:action => "unlock"}, :method => :put)
    else
      link_to('Lock', {:action => "lock"}, :method => :put)
    end
  end
  
end
