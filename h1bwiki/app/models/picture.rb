class Picture < ActiveRecord::Base
  attr_accessible :name, :image

  belongs_to :imageable, :polymorphic=>true
  
  has_attached_file :image,
                    :url  => "/assets/docs/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/docs/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 5.megabytes
  #validates_format_of :image, :with => %r{\.(docx|doc|pdf|txt)$}i
  #validates_attachment_content_type :image, :content_type => ['text/plain']
  #validates_attachment_content_type :image, :content_type => ['application/pdf', 'application/msword', 'text/plain']
end
