require 'net/http'

module OMHub
	def self.get_profile(email)
		config, base_url, http = self.setup_client
		url = URI.join base_url, base_url.path, 'profile?' + { :email => email }.to_query

		req = Net::HTTP::Get.new url
		req['Authorization'] = "Token token=%s" % config['token']

		http.request(req)
	end

  def self.get_emails_by_group(group_id)
		config, base_url, http = self.setup_client
		url = URI.join base_url, base_url.path, 'users/by_group?' + { id: group_id }.to_query
  
		req = Net::HTTP::Get.new url
		req['Authorization'] = "Token token=%s" % config['token']

		http.request(req)
  end

  def self.get_posts_by_group(group_id)
		config, base_url, http = self.setup_client
		url = URI.join base_url, base_url.path, 'posts/migrate?' + { group_id: group_id }.to_query
  
		req = Net::HTTP::Get.new url
		req['Authorization'] = "Token token=%s" % config['token']

		http.request(req)
  end

	def self.setup_client
		config = YAML::load(File.open('config/omhub.yml'))[Rails.env]
		base_url = URI.parse(config['base_url'])
		http = Net::HTTP.new(base_url.host, base_url.port)

		#unless Rails.env.development?
		  #http.use_ssl = true
		#end
		http.use_ssl = true

		[ config, base_url, http ]
	end
end
