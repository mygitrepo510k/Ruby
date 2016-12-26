class Role < ActiveRecord::Base
  PUBLIC = %w(patient doctor) # 'nurse' role is disabled for now
  DEFAULT = 'patient'

  attr_accessible :name

  has_and_belongs_to_many :users

  validates_presence_of :name

  def self.lookup(name)
    Role.find_by_name!(name.to_s)
  end
end
