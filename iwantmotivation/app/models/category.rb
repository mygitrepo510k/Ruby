class Category < ActiveRecord::Base
  attr_accessible :description, :name, :parent_id, :title, :kind, :sort_id
  
  has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy, :order=>'sort_id ASC'
  belongs_to :parent_category, :class_name => "Category"
  
  has_many :user_category
  has_many :users, :through => :user_category
  has_many :stores

  scope :m_parent_categories, :conditions => ["kind = '0' and parent_id IS NULL"], :order => 'sort_id ASC'
  scope :c_categories, :conditions => ["kind = '1'"], :order => 'sort_id ASC'

  def self.member_categories
  	ret = []
		Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>0}).each do |ct|
			ret.push([ct.name,ct.id])
			ct.subcategories.each do |sub_cat|
				sub_cat.name = ct.name + " > " + sub_cat.name
				ret.push([sub_cat.name,sub_cat.id])
			end
		end
		ret
  end
  def self.cch_categories
  	ret = []
		Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>1}).each do |ct|
			ret.push([ct.name,ct.id])
			ct.subcategories.each do |sub_cat|
				sub_cat.name = ct.name + " > " + sub_cat.name
				ret.push([sub_cat.name,sub_cat.id])
			end
		end
		ret
  end

  def self.program_categories
  	ret = []
		Category.find(:all, :conditions=>{:parent_id=>nil, :kind=>2}).each do |ct|
			ret.push([ct.name,ct.id])
			ct.subcategories.each do |sub_cat|
				sub_cat.name = ct.name + " > " + sub_cat.name
				ret.push([sub_cat.name,sub_cat.id])
			end
		end
		ret
  end
  
end
