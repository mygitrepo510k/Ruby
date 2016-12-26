class Family
  include Mongoid::Document
  include Mongoid::Timestamps
  
  ROLES = ["Mother", "Father", "Grandparent"]

  field :family_name, 		type: String
  field :family_id, 			type: Integer
  field :role_name, 			type: String

  validates :family_name, :family_id, :role_name, :presence => true

  belongs_to :user
  has_many :family_members, :dependent => :destroy

  def self.find_by_family_id(id)
  	self.where(:family_id => id).first
  end

  def family_members_count
    self.family_members.count
  end
end
