class FamilyMember
  STATUS = {:accepted=>'accepted', :sent => 'sent', :reject => 'rejected'}
  ROLES = {:father=>'Father', :mather=>'Mother', :grand_parent=>'Grand parent', :son=>'Son', :daughter=>'Daughter'}
  include Mongoid::Document
  field :first_name,              type: String
  field :last_name,               type: String
  field :email,                   type: String
  field :confirm_email,           type: String
  field :role_name,               type: String
  field :status,                  type: String, :default => 'sent'
  field :email_verification_hash, type: String
  belongs_to :family
  #belongs_to :user

#profile models
  has_one :profile,             :dependent => :destroy
  has_one :milestone,           :dependent => :destroy
  has_one :interest,            :dependent => :destroy
  

#school models
  has_many :schools,            :dependent => :destroy
  has_many :assignments,        :dependent => :destroy
  has_many :feedbacks,          :dependent => :destroy
  has_many :holidays,           :dependent => :destroy
  has_many :teachers,           :dependent => :destroy

#activities models  
  has_many :child_profile_healths,                        :dependent => :destroy
  has_many :general_health_issues,                        :dependent => :destroy
  has_many :child_profile_health_test_reports,            :dependent => :destroy
  has_many :child_profile_health_vaccination_medications, :dependent => :destroy
  has_many :child_profile_activities,                     :dependent => :destroy
  has_many :child_award_and_honours,                      :dependent => :destroy
  has_many :child_profile_exams,                          :dependent => :destroy
  has_many :injuries,                                     :dependent => :destroy
  has_many :major_illnesses,                              :dependent => :destroy
  
  
  validate :in_case_parent?

  def in_case_parent?
    if self.role_name == "Mother" or self.role_name == "Father" or self.role_name == "Grandparent"
      return true
    else
      self.email = "" and self.confirm_email = "" 
      return false
    end
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def self.find_by_email_and_family_id(email, id)
    self.where(:email=>email, :family_id => id).first
  end
  def self.find_by_email_and_family_id_and_status(fm_email,family_id,status)
    self.where(:email => fm_email, :fmaily_id => family_id, :status => status).first
  end

  def profile_image(type)
    return 'default.jpg' if self.profile.nil? or self.profile.picture.nil?
    self.profile.picture.photo.url(type)
  end
  def parent_list
    parent_list=[]
    self.family.family_members.each do |parent_fm|
      if parent_fm.status == FamilyMember::STATUS[:accepted]
        if parent_fm.role_name == FamilyMember::ROLES[:father] || parent_fm.role_name == FamilyMember::ROLES[:mather]
          parent_list << parent_fm
        end
      end
    end
    return parent_list
  end
  def age    
    if self.profile.present? and self.profile.birth_day.present?
      age = DateTime.now.year-self.profile.birth_day.year
    else
      age = 'not set'
    end
    age
  end

  def cf_activity_upcomming_lists
    upcomming_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_activities.each do |activity|
      if activity.start_date >= current_date
        upcomming_lists << activity
      end
    end
    return upcomming_lists
  end
  def cf_activity_past_lists 
    pst_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_activities.each do |activity|
      if activity.start_date < current_date
        pst_lists << activity
      end
    end
    return pst_lists
  end


  def cphvm_upcomming_lists
    #ChildProfileHealthVaccinationMedication.where('due_date >= "#{t}"').order_by('created_at desc')
    upcomming_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_health_vaccination_medications.each do |cp|
      if cp.due_date >= current_date
        upcomming_lists << cp
      end
    end
    return upcomming_lists
  end
  def cphvm_past_lists 
    pst_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_health_vaccination_medications.each do |cp|
      if cp.due_date < current_date
        pst_lists << cp
      end
    end
    return pst_lists
  end


  def cphtr_upcomming_lists
    #ChildProfileHealthTestReport.where('due_date >= "#{t}"').order_by('created_at desc')
    upcomming_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_health_test_reports.each do |cp|
      if cp.test_date >= current_date
        upcomming_lists << cp
      end
    end
    return upcomming_lists
  end
  def cphtr_past_lists 
    pst_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_health_test_reports.each do |cp|
      if cp.test_date < current_date
        pst_lists << cp
      end
    end
    return pst_lists
  end

  def school_name_list
    school_name_list = []
    school_name_list << "Please add School" and return school_name_list if self.schools.blank?
    self.schools.each do |school|
      tmp = school.name
      if school.current_school
        tmp = school_name_list[0]
        school_name_list[0] = school.name
      else
        school_name_list << tmp    
      end      
    end
    return school_name_list
  end

  def class_name_list
    class_name_list = []    
    class_name_list << "Please add class" and return class_name_list if self.schools.blank?
    self.schools.each do |school|
      unless school.school_cls.blank? 
        school.school_cls.each do |cls|
          tmp = school.name.to_s + " : " + cls.name.to_s
          if cls.current_class
            tmp = class_name_list[0]
            class_name_list[0] = school.name.to_s + " : " + cls.name.to_s
          else
            class_name_list << tmp    
          end        
        end     
      end
    end
    return class_name_list
  end

  def assign_upcomming_lists
    #ChildProfileHealthTestReport.where('due_date >= "#{t}"').order_by('created_at desc')
    upcomming_lists=[]    
    current_date = DateTime.now-1
    self.assignments.all.each do |assign|
      if assign.due_date.to_datetime >= current_date
        upcomming_lists << assign
      end
    end
    return upcomming_lists
  end
  def assign_past_lists 
    pst_lists=[]    
    current_date = DateTime.now-1
    self.assignments.all.each do |assign|
      if assign.due_date.to_datetime < current_date
        pst_lists << assign
      end
    end
    return pst_lists
  end 
  
  def upcomming_child_profile_exams
    child_profile_exams
    upcomming_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_exams.all.each do |exam|
      if exam.start_date.to_datetime >= current_date
        upcomming_lists << exam
      end
    end
    return upcomming_lists
  end
  def past_child_profile_exams
    pst_lists=[]    
    current_date = DateTime.now-1
    self.child_profile_exams.all.each do |exam|
      if exam.start_date.to_datetime < current_date
        pst_lists << exam
      end
    end
    return pst_lists
  end

  def parent?
    if self.role_name == "Father" || self.role_name == "Mother" || self.role_name == "Grand parent"
      return true
    else
      return false
    end
  end
  def child?
    if self.role_name == "Son" || self.role_name == "Daughter"
      return true
    else
      return false
    end
  end

  def user_id
    self.family.user.id
  end

  def feedbacks_of_class(cls_name)
    self.feedbacks.where(:class_name=>cls_name)
  end

  def holidays_of_class(cls_name)
    self.holidays.where(:class_name=>cls_name)
  end

  def ha_filter_data(opt)    
    self.child_award_and_honours.where(:from=>opt)
  end
end
