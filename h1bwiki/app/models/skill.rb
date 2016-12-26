class Skill < ActiveRecord::Base
	belongs_to :skillable, :polymorphic => true
  belongs_to :skill_list
  attr_accessible :skill_list_id
end
