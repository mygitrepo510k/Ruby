class ChildAwardAndHonour
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field	 :title,              :type => String
  field	 :award_date,         :type => Date
  field	 :from,               :type => String
  field	 :category,           :type => String
  field	 :subject,            :type => String
  field	 :add_to_timeline,    :type => Boolean
  field	 :upload_photo,       :type => String
  field	 :description,        :type => String

  validates :title, :award_date, :presence => true
  has_mongoid_attached_file :photo,
                    :styles => { :full => "300x300>", :thumb => "100x100>" },
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                    :default_url => "/images/:style/missing.png"
    
  belongs_to :family_member 
  
end