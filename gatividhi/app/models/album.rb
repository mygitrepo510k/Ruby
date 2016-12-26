class Album
  include Mongoid::Document  
  field :name, type: String
  field :status, type: String
  field :order_id, type: Integer
  belongs_to :user
  has_many :pictures, :as => :imageable, :dependent => :destroy
end
