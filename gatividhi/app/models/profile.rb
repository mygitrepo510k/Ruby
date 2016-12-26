class Profile
  include Mongoid::Document
  include Mongoid::Timestamps
  field :first_name,      type: String
  field :middle_name,     type: String
  field :last_name,       type: String
  field :email,           type: String
  field :birth_day,       type: Date
  field :country,         type: String
  field :state,           type: String
  field :city,            type: String
  field :address_line1,   type: String
  field :address_line2,   type: String
  field :pin_code,        type: String
  field :mother_tongue,   type: String
  field :nationality,     type: String

  has_one :picture, :as => :imageable, :dependent => :destroy
  belongs_to :user
  belongs_to :family_member

end
