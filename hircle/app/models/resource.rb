class Resource < ActiveRecord::Base

  # pointer is url of file.This could be url of the remote file.
  
  attr_accessible :name, :company_id, :label, :pointer, :update_at, :user_id,
                  :conversation_id, :department_id, :attach, :resource_type
  
  #support multiple types
  has_attached_file :attach,
                    :styles => lambda{ |a|
                                  ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? {
                                  :thumb=> "100x100#",
                                  :small  => "150x150>",
                                  :medium => "300x300>" }: {}
                                 }
  #:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"                
                  
  belongs_to :user  
  belongs_to :conversation
  belongs_to :department
  
  def full_path
    attach.url(:original)
  end


end
