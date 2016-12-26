class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # Will to be used later.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Setup for assigning current password for user 
  attr_accessor :current_password

  # Setup accessible (or protected) attributes for your model
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id, :department_id, :status,
                  :first_name,:last_name,:company_id,:id, :current_password
  
  #attr_accessor :email, :first_name, :last_name

  #has_and_belongs_to_many :roles  # Mani - This cannot be the case - only user can have one role
  belongs_to :role

  #add by Yang

  # status: onling or offline
  # add avatar and full name
  
  has_attached_file :avatar,:styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  belongs_to :company

  belongs_to :department
  #has_many :tasks, :through => :tasks_users
  has_and_belongs_to_many :tasks
  has_many :resources
  
  
  has_many :social_authentications
  
  has_one :profile
  
  has_many :job_applications  
  has_many :jobs, :through=>:job_applications

  has_many :assignments,:foreign_key => "assignee_id" #To know which tasks are assigned to me
  has_many :tasks ,:foreign_key => "assignor_id" #To know which tasks I have created

  has_and_belongs_to_many  :space


  has_many :user_contacts, :class_name => :UserContact, :conditions => {:connected => true}
  has_many :user_followings, :class_name => :UserContact, :conditions => {:connected => false}
  has_many :user_followers, foreign_key: :contact_id, class_name: :UserContact, :conditions => {:connected => false}

  # searchable do
  #       text :email, :first_name, :last_name
  #     end
  scope :online, lambda { where('updated_at >= ?', 5.minutes.ago).order('created_at desc')}


  has_many :friends


  def name_from_email 
    email.split('@')[0].gsub(/[^a-z ^0-9]/, '-') 
  end

  def search_users(search)
    reject_ids = self.user_contacts.map(&:contact_id).push(self.id)
    self.class.search{fulltext search}.results.reject{|user| reject_ids.include?(user.id)}
  end
     
  
  def full_name
    [first_name, last_name].join(" ")
  end
  
end
