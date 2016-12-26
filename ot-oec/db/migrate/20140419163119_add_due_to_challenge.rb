class AddDueToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :due, :datetime
  end
end
