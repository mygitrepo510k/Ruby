class Upload
  include Paperclip::Glue
  include Mongoid::Document
  field :upload_file_name, type: String
  field :upload_content_type, type: String
  field :upload_file_size, type: String
  field :artist_id, type: Integer
  
  belongs_to :artist

  has_attached_file :upload

  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => upload_path(self),
      "delete_type" => "DELETE" 
    }
  end
end
