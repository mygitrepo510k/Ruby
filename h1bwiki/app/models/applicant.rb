class Applicant < ActiveRecord::Base
  belongs_to :user
  belongs_to :post_job
  attr_accessible :bid_sentence, :pictures_attributes, :user_id, :post_job_id

  has_many :pictures, :as => :imageable, :dependent => :destroy

  accepts_nested_attributes_for :pictures, :allow_destroy=>true, :reject_if => :all_blank

  def image_urls
  	urls = []
  	self.pictures.each do |picture|
  		urls << picture.image.url
  	end
  end
end
