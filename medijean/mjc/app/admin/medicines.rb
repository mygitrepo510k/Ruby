ActiveAdmin.register Medicine do
  
  controller do
    def show
      @medicine = Medicine.find(params[:id])
      @versions = @medicine.versions 
      @medicine = @medicine.versions[params[:version].to_i].reify if params[:version]
      show!
    end
  end

  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @medicine = Medicine.find(params[:id])
    @versions = @medicine.versions
    render "layouts/history"
  end

  action_item :only => :show do
    link_to('History', :action => "history")
  end

end
