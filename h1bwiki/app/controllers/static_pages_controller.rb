class StaticPagesController < ApplicationController
  def home        
    if user_signed_in?
      if current_user.account_type == "employer"
        redirect_to :posts_view
      else
        redirect_to :search_home
      end
    end
  end

  def about
  end

  def help
  end

  def contact
  end

  def signup
  end
# For employer  
  def post_main
  end
  def posts
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @post_jobs = current_user.post_jobs.paginate(:page => params[:job_page], :per_page => 10)
      @post_trainings = current_user.post_trainings.paginate(:page => params[:trining_page], :per_page => 10)
      @post_mentors = current_user.post_mentors.paginate(:page => params[:mentor_page], :per_page => 10)
    end
  end
# For Job Seeker
  def jobseeker_post_main
  end
  def jobseeker_posts
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      @jobseeker_jobs = current_user.jobseeker_jobs.paginate(:page => params[:job_page], :per_page => 10)
      @jobseeker_trainings = current_user.jobseeker_trainings.paginate(:page => params[:trining_page], :per_page => 10)
      @jobseeker_mentors = current_user.jobseeker_mentors.paginate(:page => params[:mentor_page], :per_page => 10)
    end
  end
  def search_home    
    
    @search_emp_jobs, @search_seeker_jobs, @search_emp_trainings, @search_seeker_trainings, @search_emp_mentors, @search_seeker_mentors = [],[],[],[],[],[]
    @search_skill_res = @search_company_res = []
    @search_type = params[:search_type].blank? ? 0 : params[:search_type]
    @job_type = params[:type]
    cond_text, cond_values = [], []
    title = params[:title]
    city = params[:city]
    @results = []
    if @job_type == '1' or @job_type == '0'
      if title.present?
        cond_text << "(lower(job_title) LIKE lower(?) OR lower(job_description) LIKE lower(?))"
        cond_values << "%#{title}%"
        cond_values << "%#{title}%"
      end
      if city.present?
        cond_text << "lower(job_city) = lower(?)" 
        cond_values << "#{city}"
      end
    elsif @job_type =='2'
      if title.present?
        cond_text << "(lower(job_title) LIKE lower(?) OR lower(job_description) LIKE lower(?))"
        cond_values << "%#{title}%"
        cond_values << "%#{title}%"
      end      
    end


    if @search_type == '0'
      if @job_type == '1'
        res0 = PostJob.find(:all, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        res1 = PostJob.find(:all, :conditions=>["lower(skill_lists.name)=lower(?)", params[:title]], :joins=>"INNER JOIN skills on  post_jobs.id=skills.skillable_id INNER JOIN skill_lists ON skills.skill_list_id=skill_lists.id")
        res2 = PostJob.find(:all, :conditions=>["lower(users.company_name)=lower(?)", params[:title]], :joins=>"INNER JOIN users on  post_jobs.user_id=users.id")
        @search_emp_jobs = res0 | res1 | res2
        ids = @search_emp_jobs.map { |job| job.id }
        
        @search_emp_jobs = PostJob.where(:id=>ids).paginate(:page => params[:page_num], :per_page=>10)
        if @search_emp_jobs.blank?
          @search_emp_jobs = jobs_by_user('emp_jobs',title)
          if @search_emp_jobs.present?
            @search_emp_jobs = @search_emp_jobs.paginate(:page => params[:page_num], :per_page => 10)
          else
            @search_emp_jobs = []
          end
        end
        @search_seeker_jobs = []
      elsif @job_type == '2'
        if city.present?
          city = "%" + city + "%"
          @search_seeker_jobs=[]
          User.find(:all, :conditions => ["city LIKE ?", city]).each do |user|
            @search_seeker_jobs += user.jobseeker_jobs.paginate(:page => params[:page_num], :per_page => 10, :order => "created_at DESC")
          end
        else
          @search_seeker_jobs = JobseekerJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        end
        if @search_seeker_jobs.blank?
          @search_seeker_jobs = jobs_by_user('seek_jobs',title)
          if @search_seeker_jobs.present?
            @search_seeker_jobs = jobs_by_user('seek_jobs',title).paginate(:page => params[:page_num], :per_page => 10)
          else
            @search_seeker_jobs = []
          end
        end
        @search_emp_jobs = []
        @search_skill_res =[]
        @search_company_res = []
      else        
        res0 = PostJob.find(:all, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        res1 = PostJob.find(:all, :conditions=>["lower(skill_lists.name)=lower(?)", params[:title]], :joins=>"INNER JOIN skills on  post_jobs.id=skills.skillable_id INNER JOIN skill_lists ON skills.skill_list_id=skill_lists.id")
        res2 = PostJob.find(:all, :conditions=>["lower(users.company_name)=lower(?)", params[:title]], :joins=>"INNER JOIN users on  post_jobs.user_id=users.id")
        @search_emp_jobs = res0 | res1 | res2
        ids = @search_emp_jobs.map { |job| job.id }
     
        @search_emp_jobs = PostJob.where(:id=>ids).paginate(:page => params[:page_num], :per_page=>10)        
        if @search_emp_jobs.blank?
          @search_emp_jobs = jobs_by_user('emp_jobs',title)
          if @search_emp_jobs.present?
            @search_emp_jobs = @search_emp_jobs.paginate(:page => params[:page_num], :per_page => 10)
          else
            @search_emp_jobs = []
          end
        end
        if city.present?
          city = "%" + city + "%"
          @search_seeker_jobs=[]
          User.find(:all, :conditions => ["city LIKE ?", city]).each do |user|
            @search_seeker_jobs += user.jobseeker_jobs.paginate(:page => params[:page_num], :per_page => 10, :order => "created_at DESC")
          end
        else
          @search_seeker_jobs = JobseekerJob.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        end
        
        if @search_seeker_jobs.blank?
          @search_seeker_jobs = jobs_by_user('seek_jobs',title)
          if @search_seeker_jobs.present?
            @search_seeker_jobs = jobs_by_user('seek_jobs',title).paginate(:page => params[:page_num], :per_page => 10)
          else
            @search_seeker_jobs = []
          end
        end
      end
    elsif @search_type == '2'
      @search_skill_res =[]
      if @job_type == '1'
        res0 = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        res1 = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions=>["lower(users.company_name)=lower(?)", params[:title]], :joins=>"INNER JOIN users on  post_trainings.user_id=users.id")
        res0 = res0 | res1
        ids = res0.map { |training| training.id }
        @search_emp_trainings = PostTraining.where(:id=>ids).paginate(:page => params[:page_num], :per_page => 10)
        @search_seeker_trainings = []
      elsif @job_type == '2'
        @search_seeker_trainings = JobseekerTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        @search_emp_trainings = []
        @search_company_res = []
      else
        res0 = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions => [cond_text.join(" AND "), *cond_values], :order => "created_at DESC")
        res1 = PostTraining.paginate(:page => params[:page_num], :per_page => 10, :conditions=>["lower(users.company_name)=lower(?)", params[:title]], :joins=>"INNER JOIN users on  post_trainings.user_id=users.id")
        res0 = res0 | res1
        ids = res0.map { |training| training.id }
        @search_emp_trainings = PostTraining.where(:id=>ids).paginate(:page => params[:page_num], :per_page => 10)
        @search_seeker_trainings = JobseekerTraining.search(params[:title])

      end
    elsif @search_type == '1'
      @start = params[:indeed_page_num].nil? ? 0 : params[:indeed_page_num]      
      uri = URI.parse("http://api.indeed.com/ads/apisearch?publisher=6100857881070797&q=#{params[:job_title].delete(" ").gsub(",","%2C")}&l=#{params[:location]}&sort=date&radius=&st=&jt=internship&format=json&start=#{@start.to_i*10}&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      data = JSON.parse(response.body)
      @results = data["results"]
    else
      @search_emp_jobs = PostJob.paginate(:page => params[:page_num], :per_page=>10)
      @search_emp_trainings = PostTraining.paginate(:page => params[:page_num], :per_page => 10)
      uri = URI.parse("http://api.indeed.com/ads/apisearch?publisher=6100857881070797&q=Java&l=&sort=date&radius=&st=&jt=internship&format=json&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      data = JSON.parse(response.body)
      @results = data["results"]
    end

  end  

  def search_indeed    
    uri = URI.parse("http://api.indeed.com/ads/apisearch?publisher=6100857881070797&q=#{params[:title]}&l=#{params[:location]}&sort=&radius=&st=&jt=&start=&limit=&fromage=&filter=&latlong=1&co=us&chnl=&userip=1.2.3.4&useragent=Mozilla/%2F4.0%28Firefox%29&v=2")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)
    #data = JSON.parse(response.body)
    data = Hash.from_xml(response.body)
    @results = data["response"]["results"]["result"]
    render :text=>@results.inspect and return
  end

  def account_setup
    redirect_to root_url and return unless current_user.present?
    @company = current_user.company.present? ? current_user.company : current_user.build_company
    @contact = current_user.contact.present? ? current_user.contact : current_user.build_contact
  end

  def update_profile
    redirect_to root_url and return unless current_user.present?
    
    if current_user.company.present?
      @company = current_user.company
      @company.update_attributes(params[:company])
    else
      @company = current_user.build_company params[:company]
    end
    @company.save
    if current_user.contact.present?
      @contact = current_user.contact
      @contact.update_attributes(params[:contact])
    else
      @contact = current_user.build_contact params[:contact]
    end
    @contact.save
    #render :text=>@company.inspect and return
    redirect_to '/account_details' and return
  end

  def account_details
    redirect_to root_url and return unless current_user.present?
    @company = current_user.company
    @contact = current_user.contact
  end

  def change_passwd
    redirect_to root_url and return unless current_user.present?
  end
  
  def reset_passwd
    redirect_to root_url and return unless current_user.present?
    user = User.find(current_user.id)
    if user && user.valid_password?(params[:cur_pass])
      user.password=params[:new_pass]
      user.password_confirmation=params[:conf_pass]
      user.save
      sign_in(:user, user)
      flash[:notice] = "Your password was changed successfuly"
      render :nothing => true, :status=>200 and return
    else
      flash[:notice] = "Please check current password"
      render :nothing => true, :status=>409 and return
    end
    render :nothing => true, :status=>409 and return
  end

  def forward
    flash[:notice] = "Your email has been forwarded in the lightbox"
    if params[:forward][:seeker_id].present?
      UserMailer.forward(params[:from_email], params[:to_email], params[:name], params[:forward][:post_job_id],1).deliver
      redirect_to job_seeker_path(params[:forward][:post_job_id])
    else
      UserMailer.forward(params[:from_email], params[:to_email], params[:name], params[:forward][:post_job_id],0).deliver
      redirect_to post_job_path(params[:forward][:post_job_id])
    end    
  end
  
  def training_forward
    flash[:notice] = "Your email has been forwarded in the lightbox"
    if params[:forward][:seeker_id].present?
      UserMailer.training_forward(params[:from_email], params[:to_email], params[:name], params[:forward][:post_job_id],1).deliver
      redirect_to jobseeker_training_path(params[:forward][:post_job_id])
    else
      UserMailer.training_forward(params[:from_email], params[:to_email], params[:name], params[:forward][:post_job_id],0).deliver
      redirect_to post_training_path(params[:forward][:post_job_id])
    end    
  end

  
  def postings
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      redirect_to employer? ? posts_view_path : jobseeker_posts_path
    end
  end
  def post_mains
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      redirect_to employer? ? post_main_path : jobseeker_post_main_path
    end
  end

  def jobs_by_user(opt,company)
    jobs = []
    res = nil
    users = User.find(:all, :conditions => ["lower(company_name) LIKE ?", "%#{company}%".downcase])
    
    if users.present?
      users.each do |u|
        if opt == 'emp_jobs'
          u.post_jobs.each do |pj|
            jobs << pj
            ids = jobs.map(&:id)
            res = PostJob.where(id:ids)
          end
        elsif opt == 'seek_jobs'
          u.jobseeker_jobs.each do |pj|
            jobs << pj
            ids = jobs.map(&:id)
            res = JobseekerJob.where(id:ids)
          end
        end
      end
    end
    return res
  end
end
