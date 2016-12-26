class H1bempTopjob < ActiveRecord::Base
  belongs_to :h1bemp
  attr_accessible :h1bemp_id, :avgsalary, :employertitle, :flag, :rn, :totalcount
end
