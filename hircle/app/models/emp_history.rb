class EmpHistory < ActiveRecord::Base
  attr_accessible :company, :end_date, :job_desc, :job_title, :start_date
end
