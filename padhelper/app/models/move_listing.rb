class MoveListing < ActiveRecord::Base
  attr_accessible :end-address, :move-type, :notes, :packing, :start-address, :timestamp, :user_id
end
