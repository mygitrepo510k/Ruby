class Group < ActiveRecord::Base
  attr_accessible :description, :ispublic, :moderator, :name, :title

  has_and_belongs_to_many :users

  validate :name, :title, :description, presence: true

  has_many :invites
  has_many :invited_users, :through => :invites, :class_name => "User"
end
