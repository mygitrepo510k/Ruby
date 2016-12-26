class ChangeFieldsName < ActiveRecord::Migration
  def up
  	rename_column(:jobseeker_jobs, :title	, :job_title	)
  	rename_column(:jobseeker_jobs, :description, :job_description)

  	rename_column(:jobseeker_trainings, :title	, :job_title	)
  	rename_column(:jobseeker_trainings, :description, :job_description)

  	rename_column(:jobseeker_mentors, :title	, :job_title	)
  	rename_column(:jobseeker_mentors, :description, :job_description)

  end

  def down
  	rename_column(:jobseeker_jobs, :job_title	, :title	)
  	rename_column(:jobseeker_jobs, :job_description, :description)

  	rename_column(:jobseeker_trainings, :job_title	, :title	)
  	rename_column(:jobseeker_trainings, :job_description, :description)

  	rename_column(:jobseeker_mentors, :job_title	, :title	)
  	rename_column(:jobseeker_mentors, :job_description, :description)
  end
end
