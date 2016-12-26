class ConversationsHaveAndBelongToManyEmployees < ActiveRecord::Migration
   def self.up
    create_table :coversations_users, :id => false do |t|
      t.references :coversation, :user
    end
  end

  def self.down
    drop_table :coversations_users
  end
end
