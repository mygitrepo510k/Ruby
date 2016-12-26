class Company < ActiveRecord::Base
  attr_accessible :accommodation, :address1, :address2, :city, :country, :description, :everified, :sp_transfer, 
  								:state, :training_provided, :website, :zip, :picture_attributes
  belongs_to :user
  
  has_one :picture, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :picture, :allow_destroy=>true, :reject_if => :all_blank
end
