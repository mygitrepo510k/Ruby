class AddApprovedToUserChallenge < ActiveRecord::Migration
  def change
    add_column :user_challenges, :approved_by_id, :integer
    add_column :user_challenges, :approved_at, :datetime
  end
end
