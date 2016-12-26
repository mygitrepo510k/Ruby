# == Schema Information
#
# Table name: profile_answers
#
#  id                  :integer          not null, primary key
#  profile_question_id :integer
#  answer              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class ProfileAnswer < ActiveRecord::Base
  belongs_to :profile_question
  def to_s
    answer
  end
end
