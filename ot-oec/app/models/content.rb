require 'abstract_base_model'
require 'wistia'

class Content < ModelWithMedia
	belongs_to :created_by, class_name: 'User'
  belongs_to :program 

	has_many :content_group_items
	has_many :content_groups, through: :content_group_items
	has_many :comments, as: :commentable
  
  has_many :content_tags
  has_many :tags, through: :content_tags

	attr_accessible :name, :created_by, :description, :url, :filepicker_url,
    :file, :wista, :image, :content_type, :wistia_id, :player_embed, :created_by_id, :month, :option
  attr_reader :time_tag, :category_tag

  # Now obsolete
  after_create :process_uploaded_file, if: :has_file?
  # ---------

  after_create :process_link, if: :is_link?
  after_create :process_filepicker_link, if: :is_filepicker?

	mount_uploader :file, FileUploader
	mount_uploader :image, AvatarUploader

  validates :url, url: { allow_blank: true, allow_nil: true }

	enum content_type: [ :link, :file, :video, :image ]

  CONTENT_TYPES = %w[video file image link]
  CONTENT_OPTIONS = %w[OT\ Philosophy OM\ Training Coaching\ Skills Sales\ &\ Biz\ Dev Industry\ of\ Orgasm]

  def set_wistia_params(params)
    self.update_attributes({ wistia_id: params['hashed_id'], image: open(params['thumbnail']['url']) })
  end

  def process_filepicker_link
    if is_image?
      image!
    elsif is_video?
      process_video
      video!
    else
      file!
    end
  end

  # Now obsolete - phasing out file uploads, switching to filepicker
  def process_uploaded_file
    if file.content_type.match('image')
      update_attribute(:image, file)
      image!
    elsif file.content_type.match('video') or wistia_id
      tmp_filename = ['./tmp/video/%s' % SecureRandom.hex(6), file.file.extension].join('.')
      file.file.move_to(tmp_filename)
      resp = Wistia.post_video(open(tmp_filename))

      self.set_wistia_params(JSON.parse(resp.body()))
      self.video!
    else
      self.file!
    end
  end
  # ---------

  def process_link
    if url.match('wistia.com/medias')
      update_attribute(:wistia_id, url.split('/').last)
      video!
    end
  end

  def wistia_id?
    self.wistia_id 
  end

  def is_link?
    self.url
  end

  def is_filepicker?
    self.filepicker_url
  end

  def set_video
    self.video!
  end

  def has_file?
    self.file.file
  end

  def grab_link_thumbnail
    if self.link? and self.url
      begin
        thumbnailer = LinkThumbnailer.generate(self.url)
        thumbnailer ? self.update_attribute(:image, open(thumbnailer.images.first[:source_url])) : nil
      rescue ArgumentError
        self.update_attribute(:image, nil)
      end
    end
  end
end
