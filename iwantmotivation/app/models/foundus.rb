class Foundus < ActiveRecord::Base
  attr_accessible :found_us_name
  has_many :users
end
