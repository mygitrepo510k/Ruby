class Job < ActiveRecord::Base
  
   attr_accessible :company_id, :title, :description, :city, :state, :zip, :field, :tag, :visibility,:logo
                   
   belongs_to  :user
   
   has_many  :job_applications
   
   has_attached_file :logo,:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/assets/missing.png"
   
   VISIBILITY = [["Public", 1],["Private", 2], ["Collage", 3]]                
  
end
