class Announcement < ActiveRecord::Base
  attr_accessible :subject, :body, :program, :created_by

  validates :subject, presence: true, allow_blank: false, allow_nil: false
  validates :body, presence: true, allow_blank: false, allow_nil: false

	has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  belongs_to :program
	belongs_to :created_by, class_name: 'User'

  #after_create :mail_announcement

  def self.last_three program
    Announcement.where(program: program).order(created_at: :desc).limit 3
  end

  def mail_announcement users = nil
    unless users
      users = self.program.users
    end

    users.each do |user|
      UserMailer.created_new_announcement(user, self).deliver
    end
  end
end
