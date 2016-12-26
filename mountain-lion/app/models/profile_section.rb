# == Schema Information
#
# Table name: profile_sections
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  displayed    :boolean          default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#  position     :integer
#  reverse_name :string(255)
#

class ProfileSection < ActiveRecord::Base
  acts_as_list
  validates :name, presence: true, format: { with: /[a-z]/i }, uniqueness: true
  has_many :profile_questions
  default_scope -> { order(:position) }

  def to_s
    name
  end
  def slug
    name.downcase.gsub(' ','-')
  end
  def self.export_json
    Jbuilder.encode do |json|
      json.sections self.all.includes(:profile_questions) do |section|
        json.name section.name
        json.displayed section.displayed
        json.questions section.profile_questions.includes(:profile_answers) do |question|
          json.question question.question
          json.answer_type question.answer_type
          json.position question.position
          json.profile_answers question.profile_answers do |answer|
            json.answer answer.answer
          end
        end
      end
    end
  end
end
