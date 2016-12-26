# This object is used to store profile claims by doctors
class DoctorClaim < ActiveRecord::Base
  attr_accessible :doctor_id, :status, :user_id
  
  enum_field :status, { pending: 0, approved: 1, rejected: 2 }

  belongs_to :user
  belongs_to :doctor

  validates_presence_of :user, :doctor, :status

  after_initialize :default_values

  private
  def default_values
    self.status ||= :pending
  end
end
