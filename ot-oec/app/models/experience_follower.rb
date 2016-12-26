class ExperienceFollower < ActiveRecord::Base
  belongs_to :user
  belongs_to :experience

	attr_accessible :user, :experience
end
