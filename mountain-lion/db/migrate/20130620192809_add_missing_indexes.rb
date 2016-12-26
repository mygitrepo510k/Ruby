class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :user_photos, :user_id
    add_index :user_profiles, :user_id
    add_index :user_questions, [ :user_id, :profile_question_id ]
    add_index :messages, :sender_id
    add_index :messages, :recipient_id
  end
end
