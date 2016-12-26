require 'abstract_base_model'

class ContentGroup < SoftDeletedModel
  has_many :content_group_items
  has_many :contents, through: :content_group_items

  accepts_nested_attributes_for :contents

  belongs_to :created_by, class_name: 'User'

  has_and_belongs_to_many :content_nodes

	attr_accessible :name, :created_by, :description, :created_at

  has_many :comments, as: :commentable

  def contents_by_type
    contents.group_by(&:content_type)
  end
end
