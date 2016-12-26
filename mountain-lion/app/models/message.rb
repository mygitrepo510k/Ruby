# == Schema Information
#
# Table name: messages
#
#  id                   :integer          not null, primary key
#  sender_id            :integer
#  recipient_id         :integer
#  subject              :string(255)
#  body                 :text
#  read                 :boolean          default(FALSE)
#  created_at           :datetime
#  updated_at           :datetime
#  deleted_by_sender    :boolean          default(FALSE)
#  deleted_by_recipient :boolean          default(FALSE)
#  abuse                :boolean          default(FALSE)
#

class Message < ActiveRecord::Base
  belongs_to :sender, class_name: 'User', foreign_key: :sender_id
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
  validates :subject, presence: true, length: { within: 2..50 }
  validates :body, presence: true, length: { maximum: 5000 }
  scope :visible_to_sender, -> { where(deleted_by_sender: false).
                                 joins(:recipient).
                                 where('users.blocked = false') }
  scope :visible_to_recipient, -> { where(deleted_by_recipient: false).
                                    joins(:sender).
                                    where('users.blocked = false') }
  scope :deleted_by_sender, -> { where(deleted_by_sender: true).
                                 joins(:recipient).
                                 where('users.blocked = false') }
  scope :deleted_by_recipient, -> { where(deleted_by_recipient: true).
                                    joins(:sender).
                                    where('users.blocked = false') }
  scope :unread, -> { where(read: false).joins(:sender).where('users.blocked = false') }
  scope :abuse, -> { where(abuse: true) }

  def set_read
    self.read = true
    save
  end
end
