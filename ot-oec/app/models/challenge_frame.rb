class ChallengeFrame < ActiveRecord::Base
	belongs_to :user
	belongs_to :challenge
	belongs_to :content_group
	belongs_to :approved_by, class_name: 'User'
	belongs_to :again_by, class_name: 'User'

	has_many :comments, as: :commentable

	attr_accessible :user, :challenge, :note, :approved_by, :approved_at,
    :private, :created_at, :content_group, :again_by, :again_at, :filepicker_url, :s3_key

	scope :submitted, -> { where('challenge_frames.content_group_id is not null') }
	scope :approved, -> { where('approved_at is not null') }
end
