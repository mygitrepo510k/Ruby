module ApplicationHelper
	def gavatar()
		email = current_user.email.downcase
		hash = Digest::MD5.hexdigest(email)
		return "http://www.gravatar.com/avatar/#{hash}"
	end

	def like_link(likeable)
	  link = Like.find_by({by: current_user, likeable: likeable}) ? 'Unlike' : 'Like'
    "<span class='like_text'>#{link}</span> (<span class='like_count'>#{likeable.likes.count}</span>)".html_safe
	end

	def duewords(date)
		return "" if date.nil?
		days = (date.to_date - DateTime.now.to_date).to_i
		if days == 0; "today"
		elsif days == 1; "tomorrow"
		elsif days == -1; "yesterday"
		elsif days < -1; "#{-days} days ago on #{date.to_date.strftime('%a, %b %d %Y')}"
		elsif days > 1; "in #{days} days on #{date.to_date.strftime('%a, %b %d %Y')}"
		end
	end
end
