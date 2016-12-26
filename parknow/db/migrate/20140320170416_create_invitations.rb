class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
    	t.integer :vendor_id
      t.integer :sender_id
      t.string :recipient_email
      t.string :token
      t.string :state,            :null => false, :default => "pending"
      t.datetime :sent_at
      t.timestamps
    end
  end
end
