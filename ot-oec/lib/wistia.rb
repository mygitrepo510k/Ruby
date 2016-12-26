require 'net/http'
require 'net/http/post/multipart'

module Wistia
  def self.post_video_by_url(link)
		config = load_config

		res = Net::HTTP.post_form URI(config['upload_url']),
			'api_password' => config['password'],
			'project_id' => config[Rails.env]['project_id'],
			'url' => link

		JSON.parse(res.body())
  end

	def self.post_video(video)
		config = load_config
		url, http = get_client(config['upload_url'])

		req = Net::HTTP::Post::Multipart.new url.path,
			'api_password' => config['password'],
			'project_id' => config[Rails.env]['project_id'],
			'file' => UploadIO.new(video,
			                       'application/octet-stream',
			                       File.basename(video))
		http.request(req)
	end

	def self.get_media_status(id)
		config = load_config
		base_url, http = get_client(config['data_url'])

		url = URI.join(base_url, base_url.path, 'medias/', [id, 'json'].join('.'))

		req = Net::HTTP::Get.new url.path
		req.basic_auth 'api', config['password']

		http.request(req)
	end

  def self.get_embed_code(id)
		config = load_config
    inner_url = config['embed_url'] % [id, 450] # id of video and max width param for embed player

    url, http = get_client(config['embed_endpoint'] % { url: inner_url }.to_query, ssl = false)

    req = Net::HTTP::Get.new [url.path, url.query].join('?')
    http.request(req)
  end

	def self.load_config
		YAML::load(File.open('config/wistia.yml'))
	end

	def self.get_client(url, ssl = true)
		url = URI.parse(url)
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = ssl

		[url, http]
	end
end
