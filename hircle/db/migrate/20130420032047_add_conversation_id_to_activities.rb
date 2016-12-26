class AddConversationIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :conversation_id, :integer
  end
end
