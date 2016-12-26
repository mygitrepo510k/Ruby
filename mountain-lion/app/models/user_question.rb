# == Schema Information
#
# Table name: user_questions
#
#  id                  :integer          not null, primary key
#  user_id             :integer
#  profile_question_id :integer
#  answer              :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class UserQuestion < ActiveRecord::Base
  belongs_to :user
  belongs_to :profile_question

  def get_answer
    return [ answer ] if profile_question.answer_type == "string"
    profile_question.profile_answers.where(id: answer.split(','))
  end
  def get_answer_ids
    case profile_question.answer_type
    when "string"
      nil
    when "check_box"
      answer.split(',')
    else
      [ answer ]
    end
  end
end
