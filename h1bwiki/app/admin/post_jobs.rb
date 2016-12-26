ActiveAdmin.register PostJob do
  index do
    column :id, :sortable => true
    column 'Type', :job_type do |post_job|
      if post_job.job_type == 0
        "Full Time"
      else
        "Contract"
      end
    end
    column 'Title', :job_title
    column 'Description', :job_description
    column :salary
    column :hourly_rate
    column :referral_amount
    column 'City', :job_city
    column 'State', :job_state
    column :created_at
    column :updated_at
    actions    
  end
end