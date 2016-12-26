require 'file_size_validator'

class Page
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :mov, MovUploader

  validates :mov,
    :file_size => { 
      :maximum => 20.megabytes.to_i
    }

end
