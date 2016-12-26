class Picture
  include Mongoid::Document
  include Mongoid::Paperclip
  TYPE={:thumb=>"thumb", :medium=>"medium", :full=>"full"}
  field :name, type: String
  field :status, type: String
  field :order_id, type: Integer

  belongs_to :imageable, :polymorphic=>true

  has_mongoid_attached_file :photo,
                    :styles => { :large => "1024x1024>", :thumb => "100x100>" },
                    :url  => "/assets/pictures/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension",
                    :default_url => "/images/:style/missing.png",
    								:convert_options => { :all => '-background white -flatten +matte' }, :processors => [:cropper]

  validates_attachment_presence :photo
  #validates_attachment_size :photo, :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif']

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :reprocess_image, :if => :cropping?
  
  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end
  
  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

  def image_path(type)
    path = self.photo.url(type)
    path = path.from(0).to(path.rindex('?')-1)
    return path
  end

private  
  def reprocess_image
    image.reprocess!
  end


end
