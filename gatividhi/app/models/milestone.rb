class Milestone
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :category, type: String
  field :time_line, type: Boolean
  field :description, type: String

  belongs_to :family_member
  has_one :picture, :as => :imageable, :dependent => :destroy
  
end
