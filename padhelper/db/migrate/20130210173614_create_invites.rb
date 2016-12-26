class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :user_id
      t.integer :invitee_id
      t.integer :listing_id

      t.timestamps
    end
  end
end
