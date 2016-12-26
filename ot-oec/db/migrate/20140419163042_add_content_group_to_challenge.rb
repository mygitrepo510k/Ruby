class AddContentGroupToChallenge < ActiveRecord::Migration
  def change
    add_column :challenges, :content_group_id, :integer
  end
end
