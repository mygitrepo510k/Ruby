# == Schema Information
#
# Table name: profile_questions
#
#  id                 :integer          not null, primary key
#  question           :string(255)
#  profile_section_id :integer
#  answer_type        :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  position           :integer
#  reverse_question   :string(255)
#

class ProfileQuestion < ActiveRecord::Base
  ANSWER_TYPES = %w{ string check_box select_list radio_group }
  acts_as_list scope: :profile_section_id
  belongs_to :profile_section
  validates :answer_type, inclusion: { within: ANSWER_TYPES }
  has_many :profile_answers
  accepts_nested_attributes_for :profile_answers, allow_destroy: true, reject_if: :all_blank
  scope :visible, -> { joins(:profile_section).where('profile_sections.displayed = true') }
  default_scope -> { order(:position) }
end
