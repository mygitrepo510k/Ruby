# encoding: utf-8

class MovUploader < CarrierWave::Uploader::Base
	include CarrierWave::Uploader::Cache
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

#   def ogg_version
#     `ffmpeg2theora #{self.path}`
# #     self.generate_cache_id
#   end

  # Create different versions of your uploaded files:
  process :thumbnail
  
  def thumbnail
  	movie = FFMPEG::Movie.new(self.path)
  	model.thumbnail = movie.screenshot("screenshot.jpg", :seek_time => 5)
  	CarrierWave.clean_cached_files!
  end

  # Process files as they are uploaded:
#   version :ogg do
# 	  process :ogg_version
# # 	  cached_file = self.retrieve_from_cache!()
# #   	self.store!(cached_file)
# 	end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(mov)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
