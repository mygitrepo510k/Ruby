class Occupation
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  field :occupation,        type: String
  field :company_name,      type: String
  field :industry,          type: String
  field :country,           type: String
  field :state,             type: String
  field :city,              type: String
  field :address_line1,     type: String
  field :address_line2,     type: String
  field :pin_code,          type: String

  belongs_to :user
end
