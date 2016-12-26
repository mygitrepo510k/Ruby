class Country < ActiveRecord::Base  

  attr_accessible :address_format, :iso_code_2, :iso_code_3, :name, :postcode, :status, :addresses_attributes, :immigration_statuses_attributes
 
end
