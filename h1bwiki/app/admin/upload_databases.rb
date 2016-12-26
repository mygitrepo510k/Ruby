ActiveAdmin.register UploadDatabase do
  index do
    column :id, :sortable => true
    column :table_name
    column :created_at
    actions    
  end

  form do |f|
    f.inputs "UploadDatabase" do
      f.input :table_name, :collection=>[:h1bemp, :h1bemp_filling, :h1bemp_topjob]
      f.input :data_content
    end
    f.actions
  end
end