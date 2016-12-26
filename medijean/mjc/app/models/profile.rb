# This model stores a patient's profile.
class Profile < ActiveRecord::Base
  has_paper_trail
  has_one :address, as: :addressable

  belongs_to :user

  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" } #, :default_url => "/images/:style/missing.png"

  enum_field :gender, { male: 0, female: 1 }

  attr_accessible :photo, :date_of_birth, :health_card_number, :first_name, :last_name, :phone, :user_id, :reason_description, :gender

  validates_presence_of :first_name, :last_name, :health_card_number, :phone, if: 'try(:user).try(:linked_doctor).nil?'
  validates_presence_of :gender, unless: 'try(:user).try(:linked_doctor).nil?' #TODO: remove that and ensure profile=nil when role eql doctor
  
  def name
    "#{self.first_name} #{self.last_name}" if self.first_name.present? and self.last_name.present?
  end

  def to_s
    "#{self.first_name} #{self.last_name}" if self.first_name.present? and self.last_name.present?
  end

end