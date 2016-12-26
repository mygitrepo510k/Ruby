require 'abstract_base_model'

class Challenge < SoftDeletedModel
	belongs_to :program
	belongs_to :created_by, class_name: 'User'
	belongs_to :content_group

	has_many :frames, class_name: 'ChallengeFrame'
	has_many :users, through: :challenge_frames
	has_many :content_group_items, through: :content_group
	has_many :contents, through: :content_group_items, source: :content_group
	has_many :comments, as: :commentable

	has_and_belongs_to_many :pods
	has_and_belongs_to_many :user_programs

  validates_presence_of :name, :description, :created_by, :program

	attr_accessible :name, :description, :created_by, :cover, :program,
    :content_group, :program, :due, :special, :filepicker_url, :thumbnail_url

	mount_uploader :cover, CoverUploader

	def self.createone(args, cover)
		c = Challenge.new(args)
		if cover; c.cover = cover; end
		c.save!
		return c
	end

  self.per_page = 10
end
