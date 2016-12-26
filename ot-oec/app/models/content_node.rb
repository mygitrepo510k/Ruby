class ContentNode < ActiveRecord::Base
	has_many :pods

	has_and_belongs_to_many :content_groups

	attr_accessible :name
end
