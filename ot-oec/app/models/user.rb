require 'omhub'
require 'net/http'
require 'abstract_base_model'

class User < SoftDeletedModel
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable #, :validatable

	attr_accessor :skip_omhub_pull
	attr_accessible :name, :email, :password, :password_confirmation, :skip_omhub_pull,
		:current_program, :super_admin, :name, :confirmed_at, :bio, :avatar, :birthday, 
		:job, :hub_id, :hub, :remember_me, :location
	validates_presence_of :name, :email, :current_program

  validates_uniqueness_of :email, scope: :deleted
  validates_uniqueness_of :hub_id, allow_nil: true, scope: :deleted

  before_create :generate_confirmation_token
  after_create :populate_hub_fields #todo - switch to condition on virtual attribute here

  has_many :user_programs
  has_many :programs, through: :user_programs
  has_many :pods, through: :user_programs

  has_many :event_attendees
  has_many :events, through: :event_attendees

  has_many :challenge_frames
  has_many :challenges, through: :challenge_frames

  has_many :experience_followers
  has_many :followed_experiences, through: :experience_followers, source: :experience

  has_many :type_forms

	has_many :comments, as: :commentable
	has_many :posts, foreign_key: 'by_id'
  has_many :likes, foreign_key: 'by_id'
  #has_many :experiences, foreign_key: 'created_for_id'

	belongs_to :current_program, class_name: 'Program'
	belongs_to :location
  mount_uploader :avatar, AvatarUploader

  self.per_page = 10

  def experiences program
    user_exp = Experience.where(program: program, created_for: self)
    executed = user_exp.order(:executed_at).select { |e| e.executed_at != nil }
    unexecuted = user_exp.order(:scheduled_for).select { |e| e.executed_at == nil }

    executed + unexecuted
  end

  # note - this method should not be called on users other than current_user
	def pod
		self.pods.find_by(program: self.current_program)
	end
  # -----

  def pod_leader current_user
    pod = pods.find_by(program: current_user.current_program)
    pod ? pod.leader : nil
  end

  def last_frame
    self.challenge_frames.joins(:challenge).where(challenges: {id: self.current_program}).order(:created_at).last
  end

  def in_program? program
    UserProgram.where(user: self, program: program).exists?
  end

  def role current_user
    UserProgram.find_by(user: self, program: current_user.current_program).role
  end

  # role checker methods
  # if program argument is not passed in, it will check the role based on the user's own current program
  # otherwise, it will check it based on the program passed in
  # --------
  def current_user_program
    UserProgram.find_by(user: self, program: self.current_program)
  end

	def student? program = nil
    if !program
      current_user_program.student?
    else
      UserProgram.find_by(user: self, program: program).student?
    end
	end

	def admin? program = nil
    if !program
      current_user_program.admin?
    else
      UserProgram.find_by(user: self, program: program).admin?
    end
	end

	def pod_leader? program = nil
    if !program
      current_user_program.pod_leader?
    else
      UserProgram.find_by(user: self, program: program).pod_leader?
    end
	end

	def player? program = nil
    if !program
      current_user_program.player?
    else
      UserProgram.find_by(user: self, program: program).player?
    end
	end

	def staff? program = nil
    if !program
      current_user_program.staff?
    else
      UserProgram.find_by(user: self, program: program).staff?
    end
	end

  # this method should be called on the current_user only or may produce unexpected results
	def leader?
    admin? or pod_leader? or staff?
  end
  # --------

  # super admin helper methods work differently since they are a column on User, not UserProgram
  # --------
  def super_admin?
    super_admin || false
  end

  def toggle_super_admin!
    toggle! :super_admin
  end
  # --------

  # role setter methods can be called on arbitrary users,
  # so the current user is passed in
  # --------
  def user_program current_user
    UserProgram.find_by(user: self, program: current_user.current_program)
  end

  def student! current_user
    user_program(current_user).student!
  end

  def pod_leader! current_user
    user_program(current_user).pod_leader!
  end

  def admin! current_user
    user_program(current_user).admin!
  end

  def player! current_user
    user_program(current_user).player!
  end

  def staff! current_user
    user_program(current_user).staff!
  end
  # ---------

  def destroy_related
    self.posts.destroy_all
    self.comments.destroy_all
    self.likes.destroy_all
    self.user_programs.destroy_all
    self.challenge_frames.destroy_all
  end

  def remove_program program
    UserProgram.find_by(user: self, program: program).delete
    update_attribute(:current_program, user_programs.first.program)
  end

	def generate_confirmation_token
		self.confirmation_token = SecureRandom.hex
	end

  def send_welcome_mail(program, host)
    generate_confirmation_token
    UserMailer.welcome_email(self, program, host).deliver
  end

  def self.import_users(users, program)
    users.each do |u|
      params = {}
      params[:name] = u['name']
      params[:email] = u['email']
      puts "attempting import for %s (%s)" % [params[:name], params[:email]]

      if user = User.create_user_or_add_to_program(params, program)
        puts "-- added to the program"
      else
        puts "-- already exists in this program"
      end
    end
  end

  def self.create_user_or_add_to_program(user_hash, program, role = nil)
    if not user = User.find_by(email: user_hash[:email])
      user_hash[:password], user_hash[:password_confirmation] = [SecureRandom.hex] * 2
		  user = User.new(user_hash)
      user.current_program = program
    elsif UserProgram.where(user: user, program: program).exists?
      return false
    end

    up =  UserProgram.create!(role: role.to_i || 0, program: program)
    user.save!
    user.user_programs << up

    return user
  end

  def self.no_intake program
    program.users - program.users.joins(:type_forms)
  end

  def self.created_new_challenge(challenge)
    challenge.program.users.each do |user|      
      UserMailer.created_new_challenge(user, challenge).deliver unless user.admin? challenge.program
    end
  end

  def self.created_new_event(event)
    event.program.users.each do |user|      
      UserMailer.created_new_event(user, event).deliver unless user.admin? event.program
    end
  end

  def self.created_new_experience(exp)
    exp.program.users.each do |user|      
      UserMailer.created_new_experience(user, exp).deliver unless user.admin?
    end
  end

  def self.created_new_blog(blog)
    User.all.each do |user|      
      UserMailer.created_new_blog(user, blog).deliver
    end
  end

  #def self.created_new_blog(blog)
  #	User.all.each do |user|  		
  #		UserMailer.created_new_blog(user, blog).deliver
  #	end
  #end

  def populate_hub_fields
    # require 'JSON'; hub = JSON.parse(open('db/seed/hubdata.json').read)
    fields = 'bio,birthday,city,email,gender,id,inspiration,job,name,om_birthday,relationship_status,state'.split(',')

    unless self.skip_omhub_pull
      response = OMHub.get_profile(self.email).body()
      unless response == 'null'
        response = JSON.parse(response)
        self.update!(response.slice('bio', 'birthday', 'job').merge(hub_id: response['id']).merge(hub: 
          JSON.generate(response.slice(*fields))))
        unless response['avatar']['url'] == '/assets/fallback/default.png'
          self.avatar = open(response['avatar']['url'])
        end
        self.save!
      end
    end
  end
end
