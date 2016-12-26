class CreateProfileQuestions < ActiveRecord::Migration
  def change
    create_table :profile_questions do |t|
      t.string :question
      t.references :profile_section
      t.string :answer_type

      t.timestamps
    end
    add_index :profile_questions, :profile_section_id
  end
end
