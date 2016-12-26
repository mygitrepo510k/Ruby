class AddReverseLabelToProfileSectionsAndQuestions < ActiveRecord::Migration
  def change
    add_column :profile_sections, :reverse_name, :string
    add_column :profile_questions, :reverse_question, :string
  end
end
