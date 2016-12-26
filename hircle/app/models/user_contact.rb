class UserContact < ActiveRecord::Base
  attr_accessible :contact, :connected, :contact_id, :user_id
  belongs_to :user
  belongs_to :contact
  validates :user, :contact, :presence => true
  validates :user_id, :uniqueness => { :scope => [:contact_id] }

  after_save :copy_contact

  def copy_contact
    if self.connected
      existed = self.class.where(contact_id:self.user_id, user_id: self.contact_id).first
      unless existed
      	UserContact.create({contact_id:self.user_id, user_id: self.contact_id, :connected => true})
      else
      	existed.update_column(:connected, true) unless existed.connected
      end
    end
  end

end
