ActiveAdmin.register Doctor do
  
  index do
    column :id
    column :first_name                    
    column :last_name     
    column :email          
    column :phone
    column "Image" do |image|
      (image_tag(image.photo.url(:thumb), :height => '100', :width => '100'))
    end
    default_actions           
  end

  show do |doctor|
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :phone
      row :fax
      row :email
      row :website
      row :status
      row :speciality
      row :physician_id
      row :created_at
      row :image do
        image_tag(doctor.photo.url, :width => '500')
      end
    end
    active_admin_comments
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Doctor Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone, :as => :phone
      f.input :photo, :as => :file, :hint => f.template.image_tag(f.object.photo.url(:thumb)) 
    end
    f.actions
  end

  controller do
    def show
      @doctor = Doctor.find(params[:id])
      @versions = @doctor.versions 
      @doctor = @doctor.versions[params[:version].to_i].reify if params[:version]
      show! #it seems to need this
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @doctor = Doctor.find(params[:id])
    @versions = @doctor.versions
    render "layouts/history"
  end

  action_item :only => :show do
    link_to('History', :action => "history", :id => doctor.id)
  end

end