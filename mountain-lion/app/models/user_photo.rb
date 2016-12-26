# == Schema Information
#
# Table name: user_photos
#
#  id                 :integer          not null, primary key
#  description        :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  approved           :boolean          default(FALSE)
#

# == Schema Information
#
# Table name: user_photos
#
#  id                 :integer          not null, primary key
#  description        :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  approved           :boolean
#
class UserPhoto < ActiveRecord::Base
  has_attached_file :image, { styles:
    { thumb:  { geometry: "100x100^", processors: [:cropper] },
      medium: { geometry: "225x225^", processors: [:cropper] },
      preview_thumb: "100x100^",
      carousel_thumb: { geometry: "50x50", convert_options: "-gravity center -crop 50x50+0" },
      large: "500x500>",
      original: "800x800>"}}.
    merge(PAPERCLIP_STORAGE_OPTIONS)
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  validates :image, attachment_presence: true, attachment_size: { less_than: 5.megabytes }
  validates :user_id, presence: true
  belongs_to :user, counter_cache: true
  scope :approved, -> { where(approved: true) }
  scope :unapproved, -> { where(approved: false) }

  def image_geometry(style = :original)
    @geometry ||= {}
    image_path = (image.options[:storage] == :s3) ? image.url(style) : image.path(style)
    @geometry[style] ||= Paperclip::Geometry.from_file(image_path)
  end

  def reprocess_image
    if cropping?
      image.reprocess!
    end
  end

  def cropping?
    !crop_x.blank? && !crop_y.blank? && crop_w.to_i != 0 && crop_h.to_i != 0
  end

  def approve!
    update_attribute(:approved, true)
  end
end
