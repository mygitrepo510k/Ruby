ActiveAdmin.register Address do

  index do                            
    column :id
    column :street
    column :unit
    column :city
    column :province
    column :postal_code
    column :country
    default_actions           
  end

  form do |f|
    f.inputs "Address Details" do
      f.input :street
      f.input :unit
      f.input :city
      f.input :province
      f.input :postal_code
      f.input :country
    end
    f.actions
  end

  controller do
    def show
      @address = Address.find(params[:id])
      @versions = @address.versions 
      @address = @address.versions[params[:version].to_i].reify if params[:version]
      show!
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @address = Address.find(params[:id])
    @versions = @address.versions
    render "layouts/history"
  end

  action_item :only => :show do
    link_to('History', :action => "history")
  end  

end
