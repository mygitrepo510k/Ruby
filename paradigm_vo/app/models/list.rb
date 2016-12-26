class List
  include Mongoid::Document
  include Mongoid::Timestamps  

	field :name
	field :voice_ids, type: Array
	field :recipient
	field :recipient_name
	field :subject
	field :message
	field :signature

	belongs_to :admin
	
	validates :name, :recipient, :recipient_name, presence: true, on: :create

end
