require 'abstract_base_model'

class Experience < SoftDeletedModel
	belongs_to :program
	belongs_to :created_by, class_name: 'User'
	belongs_to :created_for, class_name: 'User'
	belongs_to :frame, class_name: 'ContentGroup'
	belongs_to :executed_by, class_name: 'User'

  validates_presence_of :name, :created_for, :created_by, :scheduled_for

	has_many :comments, as: :commentable
  has_many :likes, as: :likeable
	has_many :experience_followers
	has_many :followers, through: :experience_followers, source: :user

	scope :public_with_frame, -> { where('private = false and frame_id is not null') }

	attr_accessible :name, :created_at, :created_by, :program,
    :created_for, :created_for_id, :frame, :executed_by, :scheduled_for, :executed_at, :content_group, :private,
    :what_came_up, :color, :emergent, :feel_seen, :go_deeper,
    :looking_to_open, :process, :possible_difficulties, :how_to_handle

	enum color: [ :green, :yellow, :red ]
	enum feel_seen: [ :yes, :no ]

	has_many :comments, as: :commentable

  self.per_page = 10
end
