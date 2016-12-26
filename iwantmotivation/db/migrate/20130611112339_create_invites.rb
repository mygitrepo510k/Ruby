class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.integer :inviter_id
      t.timestamps
    end
    add_index :invites, :user_id
    add_index :invites, :group_id
  end
end
