class ContentGroupItem < ActiveRecord::Base
  belongs_to :content_group
  belongs_to :content

	attr_accessible :content, :content_group
end
