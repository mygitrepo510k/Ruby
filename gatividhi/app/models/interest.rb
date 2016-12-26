class Interest
  include Mongoid::Document
  include Mongoid::Timestamps
  OPTIONS={:academic=>"academic", :sport=>"sport", :visual_performing_art=>"visual_performing_art", :public_speaking_intereaction=>"public_speaking_intereaction", :personal=>"personal", :volunary=>"volunary"}
  field :option_name, type: String
  field :option_value, type: String

  belongs_to :family_member


	def academics
		Interest.where(option_name: Interest::OPTIONS[:academic])
	end
	def sports
		Interest.where(option_name: Interest::OPTIONS[:sport])
	end
	def visual_performing_arts
		Interest.where(option_name: Interest::OPTIONS[:visual_performing_art])
	end
	def public_speaking_intereactions
		Interest.where(option_name: Interest::OPTIONS[:public_speaking_intereaction])
	end
	def personals
		Interest.where(option_name: Interest::OPTIONS[:personal])
	end
  def volunaries
  	Interest.where(option_name: Interest::OPTIONS[:volunary])
  end
end
