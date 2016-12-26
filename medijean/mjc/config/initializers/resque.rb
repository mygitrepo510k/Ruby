require 'resque_scheduler'

redis = YAML.load_file("#{Rails.root}/config/redis.yml")[Rails.env]
Resque.redis = Redis.current = Redis.new(:host => redis["host"], :port => redis["port"], :password => redis["password"])
