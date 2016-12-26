ActiveAdmin.register Prescription do
  index do                            
    column :id
    column :user                    
    column :description     
    column :symptom          
    column :status          
    column :expiration          
    column :administration_method          
    column :dosage          
    column :doctor_name
    column "Image" do |image|
      (image_tag(image.prescription_image.url(:thumb), :height => '100', :width => '100'))
    end
    default_actions           
  end
  
  show do |prescription|
    attributes_table do
      row :image do
        image_tag(prescription.prescription_image.url, :width => '800')
      end
      row :id
      row :user
      row :status
      row :expiration
      row :description
      row :symptom
      row :administration_method
      row :current_usage_habits
      row :dosage
      row :medicine
      row :issue_date
      row :doctor_name
      row :doctor
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Prescription Details" do

      status_keys = Prescription::STATUS.keys
      administration_method_keys = Prescription::ADMINISTRATION_METHOD.keys

      f.input :user
      f.input :status, :as => :select, :collection => status_keys
      f.input :expiration
      f.input :description
      f.input :symptom
      f.input :administration_method, :as => :select, :collection => administration_method_keys
      f.input :current_usage_habits
      f.input :dosage
      f.input :medicine
      f.input :issue_date
      f.input :doctor_name
      f.input :doctor
    end
    f.actions
  end

  controller do
    def show
      @prescription = Prescription.find(params[:id])
      @versions = @prescription.versions 
      @prescription = @prescription.versions[params[:version].to_i].reify if params[:version]
      show!
    end
  end
  sidebar :versionate, :partial => "layouts/version", :only => :show

  member_action :history do
    @prescription = Prescription.find(params[:id])
    @versions = @prescription.versions
    render "layouts/history"
  end

  member_action :approve, :method => :put  do
    @prescription = Prescription.find(params[:id])
    @prescription.status = :approved
    if @prescription.save
      flash[:notice] = "Prescription has been approved."
    else
      flash[:error] = "Prescription couldn't be approved: #{@prescription.errors.full_messages.join(",")}"
    end
    redirect_to :action => :show
  end

  action_item :only => :show do
    @prescription = Prescription.find(params[:id])

    if @prescription.status == :uploaded
      link_to('Approve Prescription', {:action => "approve"}, :method => :put)
    end
  end

  action_item :only => :show do
    link_to('History', :action => "history", :id => prescription.id)
  end

end
