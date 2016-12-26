class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.text :content
      t.integer :company_id
      t.integer :user_id

      #t.timestamps
    end
  end
end
