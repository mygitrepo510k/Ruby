class Store < ActiveRecord::Base
  belongs_to :category
  attr_accessible :category_id, :affiliate_code, :author, :content, :price, :sell_price, :title, :picture_attributes

  has_one :picture, :as => :imageable, :dependent => :destroy
  accepts_nested_attributes_for :picture

  def self.get_authors
  	author = Store.select("author").group("author")
  end
end
