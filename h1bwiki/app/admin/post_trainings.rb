ActiveAdmin.register PostTraining do
  index do
    column :id, :sortable => true    
    column 'Title', :job_title
    column 'Technology', :job_technology 
    column 'Instruction', :job_instruction do |post_training|
    	post_training.get_instruction_mode
    end
    column 'Placement', :job_placement do |post_training|
    	post_training.job_placement == 1 ? "Yes" : "No"
    end
    column 'Accomodation', :job_accomodation do |post_training|
      post_training.job_accomodation == 1 ? "Yes" : "No"
    end
    column 'City', :job_city
    column 'State', :job_state
    column 'Duration', :job_duration
    column 'Description', :job_description
    column :created_at
    column :updated_at
    actions    
  end
end
