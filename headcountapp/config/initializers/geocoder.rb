uri = URI.parse(ENV["REDISTOGO_URL"])
Geocoder.configure(

  # geocoding service (see below for supported options):
  #:lookup => :google,
	:lookup => :yandex,
  # to use an API key:
  #:api_key => "AIzaSyDrK7Y9C2PpxUqSn4pTe0inGz9XU36aHvU",
	:api_key => "",
  # geocoding service request timeout, in seconds (default 3):
  :timeout => 5,

  # set default units to kilometers:
  :units => :km,

  # caching (see below for details):
  :cache => Redis.new(:host => uri.host, :port => uri.port, :password => uri.password),
  :cache_prefix => "..."

)