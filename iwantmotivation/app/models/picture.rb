class Picture < ActiveRecord::Base
  attr_accessible :title, :image
  belongs_to :imageable, :polymorphic=>true
  belongs_to :user

  has_attached_file :image, :styles => { :thumb => "80x80>", :small => "150x150>", :medium => "200x200>", :large => "250x250>" },
                    :url  => "/assets/pictures/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:style/:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :less_than => 3.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
end
