class Tag < ActiveRecord::Base
  TYPE = %w[time category]
  
  belongs_to :added_by, class_name: 'User'
  
  has_many :content_tags
  has_many :contents, through: :content_tags
  
  validates_presence_of :name, :tag_type, :added_by_id
  
  scope :time_tags, -> { where(tag_type:'0') }
  scope :category_tags, -> { where(tag_type:'1') }
end
