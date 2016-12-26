class ScoutListing < ActiveRecord::Base
  attr_accessible :baths, :beds, :call, :drive, :max-budget, :move-in-date, :notes, :tags, :timestamp, :user_id
end
