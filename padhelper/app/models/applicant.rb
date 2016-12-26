class Applicant < ActiveRecord::Base
  attr_accessible :applicant_id, :move_listing_id, :scout_listing_id
end
