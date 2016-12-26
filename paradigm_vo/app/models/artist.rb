class Artist
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia
  include Mongoid::Search

  field :name
  field :starting_with
  field :gender
  field :category

  #embeds_one :upload

  has_many :voiceovers

  
  attr_accessible :upload_attributes
  has_one :upload;  
  accepts_nested_attributes_for :upload
  

	search_in :name

  validates :name, :gender, :category, presence: true, on: :create		

  before_save :save_artists_first_initial

  before_destroy :remove_from_list

  

# 	validates :name, uniqueness: true, if: :unique_to_category

# 	{ message: 'This artist is already in the system. Try adding new voiceover files to this artist instead.' }

# 	def unique_to_category
# 		  matched_entry = Artist.all_of(name: self.name, category: self.category).first
# 	  errors.add_to_base("already exists in this category") if matched_entry
# 	end

include Rails.application.routes.url_helpers

protected
  def save_artists_first_initial
    self.starting_with = self.name[0].upcase
  end

  def to_jq_upload
    {
      "art-name" => read_attribute(:name),
      "art-gender" => read_attribute(:gender),
      "art-cat" => read_attribute(:category),
      "file-name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => artists_path(self),
      "delete_type" => "DELETE" 
    }
  end
  
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
