module LikesHelper
	def like_link(likeable)
	  link = Like.find_by({by: current_user, likeable: likeable}) ? 'Unlike' : 'Like'
    "<span class='like_text'>#{link}</span>".html_safe
	end

  def like_count(likeable)
    count = likeable.likes.count
    elements = {
      title: count > 0 ? "title='#{likeable.likes.map { |l| l.by.name }.to_sentence} like#{count == 1 ? 's' : ''} this'".html_safe : '',
      count: count }
    "<div class='like_count_wrapper' %{title}><span class='like_count'>%{count}</span> <span class='glyphicon glyphicon-thumbs-up'></span></div>".html_safe %
      elements
  end
end
