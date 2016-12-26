require 'file_size_validator'

class Video
  include Mongoid::Document
  include Mongoid::Timestamps

	field :title, type: String
	field :description, type: String

  mount_uploader :mov, MovUploader
  mount_uploader :thumbnail, ThumbnailUploader

	validates :title, presence: true
	validates :mov, presence: { message: 'You need to select a video.' }
  validates :mov,
    :file_size => { 
      :maximum => 20.megabytes.to_i
    }

end
