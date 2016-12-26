class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  mount_uploader :photo, PhotoUploader
  
  field :photo,         		:type => String

  belongs_to :photoble, 		:polymorphic => true

  def photo_url
  	if self.photo.url.nil?
  		""
  	else
      if Rails.env.production?
        self.photo.url
      else
    		self.photo.url.gsub("#{Rails.root.to_s}/public/photo/", "/photo/")
      end
  	end
  end

end
