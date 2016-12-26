class Coachcounselor < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :experience, :helppeople, :license, :philosophy, :really_name
end
