class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.string :subject
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :conversation_id

      t.timestamps
    end
  end
end
