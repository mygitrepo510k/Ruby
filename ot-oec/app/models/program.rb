require 'abstract_base_model'

class Program < SoftDeletedModel
  has_many :user_programs
  has_many :users, through: :user_programs
  has_many :challenges
  has_many :pods
  has_many :events
  
  belongs_to :root_content_node, class_name: 'ContentNode'

	attr_accessible :name, :start_date, :end_date, :welcome_email,
    :welcome_email_subject, :hub_group_id, :root_content_node, :has_content

  validates_uniqueness_of :hub_group_id, allow_nil: true

  def students
    UserProgram.where(program: self, role: UserProgram.roles[:student]).map(&:user)
  end

  def pod_leaders
    UserProgram.where(program: self, role: UserProgram.roles[:pod_leader]).map(&:user)
  end

  def admins
    UserProgram.where(program: self, role: UserProgram.roles[:admin]).map(&:user)
  end

  def players
    UserProgram.where(program: self, role: UserProgram.roles[:player]).map(&:user)
  end

  def staff
    UserProgram.where(program: self, role: UserProgram.roles[:staff]).map(&:user)
  end
end
