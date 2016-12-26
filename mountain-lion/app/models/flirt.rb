# == Schema Information
#
# Table name: flirts
#
#  id         :integer          not null, primary key
#  message    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  position   :integer
#

class Flirt < ActiveRecord::Base
  acts_as_list
  validates :message, presence: true, length: { minimum: 5 }, uniqueness: { case_sensitive: false }
  default_scope -> { order(:position) }
end
