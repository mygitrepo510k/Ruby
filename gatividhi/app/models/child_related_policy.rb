class ChildRelatedPolicy
  include Mongoid::Document
  field :name, type: String
  field :type, type: String
  field :amount, type: String
  field :description, type: String

  belongs_to :finance

  validates :name, :type, :amount, :description, :presence => true
end
