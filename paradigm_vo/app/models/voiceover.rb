require 'file_size_validator'

class Voiceover
  include Mongoid::Document
  include Mongoid::Timestamps

	belongs_to :artist
  mount_uploader :voiceover, VoiceoverUploader
  
  field :file_name
  
  validates :voiceover, 
    :presence => true, on: :create
  validates :voiceover, 
    :file_size => { 
      :maximum => 20.megabytes.to_i 
    } 
    
    
  before_destroy :remove_from_list
  
  def remove_from_list
  	lists = List.all
  	
  	lists.each do |list|
	  	if list.voice_ids.present?
		  	list.voice_ids.delete_if { |v| v.include? self.id }
		  	list.save
			end
  	end
  end
   
end
