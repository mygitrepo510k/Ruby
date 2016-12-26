class CreateJobInvitations < ActiveRecord::Migration
  def change
    create_table :job_invitations do |t|
      t.integer :inviter_id
      t.integer :invited_id
      t.integer :job_id
      
      t.timestamps
    end
  end
end
