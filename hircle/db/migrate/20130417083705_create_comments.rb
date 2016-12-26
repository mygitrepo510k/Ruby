class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :conversation_id
      t.integer :user_id
      t.datetime :create_at

      #t.timestamps
    end
  end
end
