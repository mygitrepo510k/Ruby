class Feed < ActiveRecord::Base
  self.abstract_class = true

  def self.sort_condition(item)
    if item.class == Post
      item.bumped
    elsif item.class == Experience
      item.frame.created_at
    end
  end

  def self.feed(program, page, per_page = 10)
    items = Post.where(program: program).unpinned
    items << Experience.public_with_frame.where(program: program)
    sorted = items.flatten.sort_by { |item| sort_condition(item) }.reverse

    @items = WillPaginate::Collection.create(page || 1, per_page, sorted.length) do |pager|
      pager.replace sorted[pager.offset, per_page]
    end
  end
end
