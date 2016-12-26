require 'abstract_base_model'
require 'wistia'

class Post < ModelWithMedia
	belongs_to :program
	belongs_to :by, class_name: 'User'

  before_create :set_bumped
  after_create :process_video, if: :is_video?

	has_many :comments, as: :commentable
  has_many :likes, as: :likeable

	attr_accessible :body, :program, :by, :bumped, :filepicker_url, :s3_key, :created_at

  validates :body, presence: true, allow_blank: false, allow_nil: false

	self.per_page = 10

	scope :sort_by_bumped, -> { order('bumped DESC') }
	scope :sort_by_created, -> { order('created_at DESC') }
	scope :unpinned, -> { where(pinned: false) }
	scope :pinned, -> { where(pinned: true) }

  def self.search(user, query)
    Post.joins(:by)
      .where('program_id = ? AND (body ilike ? OR users.name ilike ?)', user.current_program_id, "%#{query}%", "%#{query}%")
      .order('created_at desc').limit(50)
  end

  def self.search_posts_and_comments(user, query)
    posts = self.search(user, query)
    post_bodies =
      posts.map{|p| {:created_at => p.created_at,
        :body => p.body, :id => p.id, :name => p.by.name, :user_id => p.by.id}}
    comments = Comment.search(user, query)
    comment_bodies =
      comments.map{|c| {:created_at => c.created_at,
        :body => c.body, :id => c.commentable_id, :name => c.by.name, :user_id => c.by.id}}
    (comment_bodies + post_bodies).sort{|x,y| y[:created_at] <=> x[:created_at]}
  end

  def self.import_hub_posts(posts)
    posts.each do |post|
      import_hub_post(post)
    end
  end

  def self.import_hub_post(p)
    unless post_by = User.find_by(hub_id: p['user_id'])
      return nil
    end

    post = Post.create(
      body: p['body'], by: User.find_by(hub_id: p['user_id']), bumped: p['bumped_at'],
      created_at: p['created_at'], s3_key: p['s3_key'], filepicker_url: p['post_link'], program: Program.first)

    p['likes'].each do |l|
      Like.create(likeable_id: post.id, likeable_type: post.class.name,
        created_at: l['created_at'], by: User.find_by(hub_id: l['user_id']))
    end

    p['comments'].each do |c|
      if comment_by = User.find_by(hub_id: c['user_id'])
        comment = Comment.create(
          body: c['body'], by: comment_by, created_at: c['created_at'],
          commentable_id: post.id, commentable_type: post.class.name)

        c['likes'].each do |cl|
          Like.create(likeable_id: comment.id, likeable_type: comment.class.name,
            created_at: cl['created_at'], by: User.find_by(hub_id: cl['user_id']))
        end
      end
    end
  end

  private
    def set_bumped
      self.bumped = Time.now
    end
end
