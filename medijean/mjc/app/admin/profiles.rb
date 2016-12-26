ActiveAdmin.register Profile do
  controller do
    def show
        @profile = Profile.find(params[:id])
        @versions = @profile.versions 
        @profile = @profile.versions[params[:version].to_i].reify if params[:version]
        show!
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @profile = Profile.find(params[:id])
    @versions = @profile.versions
    render "layouts/history"
  end

  action_item :only => :show do
    link_to('History', :action => "history")
  end

end
