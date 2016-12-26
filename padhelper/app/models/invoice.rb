class Invoice < ActiveRecord::Base
  attr_accessible :amount, :from-id, :status, :timestamp, :to-id, :user_id
end
