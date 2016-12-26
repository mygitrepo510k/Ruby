class AddUniqueIndexToUserChallenges < ActiveRecord::Migration
  def change
    add_index :user_challenges, [:user_id, :challenge_id], unique: true
  end
end
