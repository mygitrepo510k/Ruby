class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids
  # attr_accessible :title, :body

  has_and_belongs_to_many :roles

  after_create { |admin| admin.send_reset_password_instructions }
 
  def password_required?
    new_record? ? false : super
  
  end
  # Checks whether a user exists in a given role
  def role?(role)
    return !!self.roles.find_by_name(role.to_s)
  end

  # def after_database_authentication
  # 	ApplicationController.enable_paper_trail = true
  # end

  def name
    return "#{self.first_name} #{self.last_name}" if self.first_name.present?
    self.email
  end

end
