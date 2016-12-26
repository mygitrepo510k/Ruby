class CreateProfileAnswers < ActiveRecord::Migration
  def change
    create_table :profile_answers do |t|
      t.references :profile_question
      t.string :answer

      t.timestamps
    end
    add_index :profile_answers, :profile_question_id
  end
end
