class CreateUserQuestions < ActiveRecord::Migration
  def change
    create_table :user_questions do |t|
      t.integer :user_id
      t.integer :profile_question_id
      t.string :answer

      t.timestamps
    end
  end
end
