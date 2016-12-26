module DashboardHelper
  def get_application_count job
    @application = JobApplication.where(:job_id => job.id)
  end  
  
  def get_watch_count job
    @watch = JobApplication.where(:job_id => job.id, :watch => true)
  end
  
  def get_likes_count job
    @like = JobApplication.where(:job_id => job.id, :like => true)
  end
end
