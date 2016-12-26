require 'abstract_base_model'

class Comment < SoftDeletedModel
  belongs_to :commentable, polymorphic: true
  belongs_to :program
  belongs_to :by, class_name: 'User'

  has_many :likes, as: :likeable

  after_create :set_program

	attr_accessible :body, :by, :commentable_type, :commentable_id, :commentable, :program, :scope, :created_at
  validates_presence_of :body, :by

  def self.search(user, query)
    Comment.joins(:by)
      .where('program_id = ? AND (body ilike ? OR users.name ilike ?)', user.current_program_id, "%#{query}%", "%#{query}%")
      .order('created_at desc').limit(50)
  end

  def last_n(n, scope = nil)
    Comment.where(commentable: self.commentable, scope: self.scope).where('created_at > ?', self.created_at).count < n
  end

	def set_program
    update_attribute(:program, by.current_program)
	end
end
