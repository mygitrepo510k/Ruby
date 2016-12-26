class Profile < ActiveRecord::Base
  attr_accessible :address, :city, :completed-jobs, :email, :helpers-hired, :hourly-rate, :job-applications, :listings-posted, :name, :paypal-email, :portrait, :rating, :state, :user_id, :zip
end
