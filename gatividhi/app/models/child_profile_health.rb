class ChildProfileHealth
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, 	:type=> String
  field :value, :type=> String

  belongs_to :family_member 
end
