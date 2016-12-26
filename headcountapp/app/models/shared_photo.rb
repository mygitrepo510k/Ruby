class SharedPhoto
  include Mongoid::Document
  include Mongoid::Timestamps
  
  belongs_to :user
  belongs_to :event

  has_one :photo,                  :as => :photoble,       dependent: :destroy
  def photo_url
  	if self.photo.present?
  		if Rails.env.development?
        return "http://192.168.0.55:3000" + photo.photo_url
      else
        return photo.photo_url
      end
		else
			''
		end
  end
end