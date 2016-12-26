class Like < ActiveRecord::Base
  belongs_to :likeable, polymorphic: true
  belongs_to :by, class_name: 'User'

  attr_accessible :likeable_id, :likeable_type, :by_id, :created_at, :by
  validates_presence_of :likeable_id, :likeable_type, :by_id

  def self.toggle(params)
    unless like = find_by(params)
      like = create(params)
    else
      like.delete
    end
  end
end
