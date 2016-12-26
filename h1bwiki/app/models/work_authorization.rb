class WorkAuthorization < ActiveRecord::Base
	#schema info
	# belongs_to post_job   -> post_job_id
	# t.integer		id    auto_incre
	# t.integer		workauthorization_index
	

  belongs_to :post_job
  attr_accessible :post_job_id, :workauthorization_index

  WORKAUTHORIZATION = ['US Citizen', 'GC', 'H-1B', 'OPT', 'TN/EAD(GC,L2)', 'Others']

  def self.available_consts
  	consts = []
  	k = 0
  	WORKAUTHORIZATION.each do |wa|
  		consts.push(self.new(:workauthorization_index=>k))
  		k = k + 1
  	end
  	consts
  end

  def desc
  	WORKAUTHORIZATION[self.workauthorization_index]
  end
end
