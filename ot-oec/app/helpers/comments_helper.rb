module CommentsHelper
  def comments_by_scope(commentable, scope)
    scope ? commentable.comments.where(scope: scope).order(:created_at) : commentable.comments.order(:created_at)
  end

  def comment_count(commentable)
    "<span class='comment_count'>#{commentable.comments.count}</span> <span class='glyphicon glyphicon-comment'></span>".html_safe
  end
end
