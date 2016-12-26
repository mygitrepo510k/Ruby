class User
	include Mongoid::Document

  rolify

  include Mongoid::Paranoia
  include Mongoid::Timestamps

	# Include default devise modules. Others available are:
	# :token_authenticatable, :confirmable,
	# :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable, 
				 :recoverable, :rememberable, :trackable, :validatable

	## Database authenticatable
	field :first_name, :type => String
	field :last_name, :type => String
	
	field :email,							     :type => String, :default => ""
	field :encrypted_password,     :type => String, :default => ""

	validates_presence_of :email
	validates_presence_of :encrypted_password
	
	## Recoverable
	field :reset_password_token,	    :type => String
	field :reset_password_sent_at,    :type => Time

	## Rememberable
	field :remember_created_at, :type => Time

	## Trackable
	field :sign_in_count,			        :type => Integer, :default => 0
	field :current_sign_in_at,        :type => Time
	field :last_sign_in_at,		        :type => Time
	field :current_sign_in_ip,        :type => String
	field :last_sign_in_ip,		        :type => String

	# Confirmable
	field :confirmation_token,	    :type => String
	field :confirmed_at,				    :type => Time
	field :confirmation_sent_at,    :type => Time
	field :unconfirmed_email,		    :type => String # Only if using reconfirmable

	## Lockable
	# field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
	# field :unlock_token,		:type => String # Only if unlock strategy is :email or :both
	# field :locked_at,			 :type => Time


	## Token authenticatable
	# field :authentication_token, :type => String
	# run 'rake db:mongoid:create_indexes' to create indexes
	index({ email: 1 }, { unique: true, background: true })
	
	validates_presence_of :name
	attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, :created_at, :updated_at

  #has_many :families
  
  
  has_many :families
	#has_many :family_members
	has_many :albums, 		:dependent => :destroy


  has_one :profile, 		:dependent => :destroy
  has_one :occupation, 	:dependent => :destroy
  has_one :finance, 		:dependent => :destroy
  has_many :policies, 	:dependent => :destroy
  
  #def families
  #  Family.in(id: family_members.map(&:family_id))
  #end
  
  def name
  	"#{self.first_name} #{self.last_name}"
  end
  def profile_image(type)
  	return 'sample/default.jpg' if self.profile.nil? or self.profile.picture.nil?
    self.profile.picture.photo.url(type)
  end

  def request_family_members
  	rf_members_list = []
  	self.families.each do |f|
  		f.family_members.each do |fm|
  			if fm.status == FamilyMember::STATUS[:send]
  				rf_members_list << fm	
  			end
  		end
  	end
  	rf_members_list
  end

  def family_members(type)
  	members=[]
  	self.families.each do |family|
  		family.family_members.where(:status=>type).each do |member|
  			members << member
  		end
  	end
  	return members
  end
  
end
