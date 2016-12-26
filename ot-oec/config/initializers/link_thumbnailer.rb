# Use this hook to configure LinkThumbnailer bahaviors.
LinkThumbnailer.configure do |config|
  # Set mandatory attributes require for the website to be valid.
  # You can set `strict` to false if you want to skip this validation.
  # config.mandatory_attributes = %w(url title image)

  # Whether you want to validate given website against mandatory attributes or not.
  # config.strict = true

  # Numbers of redirects before raising an exception when trying to parse given url.
  # config.redirect_limit = 3

  # List of blacklisted urls you want to skip when searching for images.
  # config.blacklist_urls = [
  #   %r{^http://ad\.doubleclick\.net/},
  #   %r{^http://b\.scorecardresearch\.com/},
  #   %r{^http://pixel\.quantserve\.com/},
  #   %r{^http://s7\.addthis\.com/}
  # ]

  # Included Rmagick attributes for images. See http://www.imagemagick.org/RMagick/doc/
  # for more details.
  # 'source_url' is a custom attribute and should always be included since this
  # is where you'll find the image url.
  # config.image_attributes = %w(source_url size type)

  # Fetch 10 images maximum.
  # config.limit = 10

  # Return top 5 images only.
  # config.top = 5

  # Set user agent
  # config.user_agent = 'linkthumbnailer'

  # Enable or disable SSL verification
  # config.verify_ssl = true

  # HTTP open_timeout: The amount of time in seconds to wait for a connection to be opened.
  # config.http_timeout = 5

  # HACK - force rails to save images below 20k into a tmp file instead of a StringIO buffer
  # http://stackoverflow.com/questions/694115/why-does-ruby-open-uris-open-return-a-stringio-in-my-unit-test-but-a-fileio-in
  require 'open-uri'
  OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
  OpenURI::Buffer.const_set 'StringMax', 0
end
