class AdvancesPaid
  include Mongoid::Document
  field :title, type: String
  field :date, type: String
  field :amount, type: String
  field :description, type: String

  belongs_to :finance
end
