ActiveAdmin.register User do
  index do
    column :id, :sortable => true    
    column :email
    column 'Name', :first_name
    column 'Company Name', :company_name
    column :city
    column :account_type
    column :contact_number
    column :approved
    column :created_at
    column :updated_at
    actions    
  end

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :company_name
    	f.input :address1
    	f.input :address2
    	f.input :city
    	f.input :user_name
      f.input :contact_number
      f.input :approved
    end
    f.actions
  end
end
