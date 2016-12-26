class Review < ActiveRecord::Base
  belongs_to :h1bemp
  belongs_to :user
  attr_accessible :h1bemp_id, :user_id, :legal, :paidontime, :placement
end
