class ChildProfileHealthTestReport
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  field :title,          :type=> String
  field :from,          :type=> String
  field :report_date,   :type=> Date
  field :test_date,     :type=> Date
  field :health_issue,  :type=> String
  field :parent_res,    :type=> String
  field :reminder,      :type=> String
  field :type,          :type=> String
  
  
  validates_format_of :title, :with => /\A[a-zA-Z]+\z/,  :message => "Only letters allowed"

  has_mongoid_attached_file :photo,
                    :styles => { :full => "300x300>", :thumb => "100x100>" },
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension",
                    :default_url => "/images/:style/missing.png"

  belongs_to :family_member 
  
  def self.upcomming_lists
    #ChildProfileHealthTestReport.where('due_date >= "#{t}"').order_by('created_at desc')
    upcomming_lists=[]    
    current_date = DateTime.now
    ChildProfileHealthTestReport.all.each do |cp|
      if cp.test_date >= DateTime.now
        upcomming_lists << cp
      end
    end
    return upcomming_lists
  end
  def self.past_lists 
    pst_lists=[]    
    current_date = DateTime.now
    ChildProfileHealthTestReport.all.each do |cp|
      if cp.test_date < DateTime.now
        pst_lists << cp
      end
    end
    return pst_lists
  end
end
