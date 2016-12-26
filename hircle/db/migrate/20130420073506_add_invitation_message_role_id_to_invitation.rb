class AddInvitationMessageRoleIdToInvitation < ActiveRecord::Migration
  def change
    add_column :invitations, :invitation_message, :string
    add_column :invitations, :role_id, :string
  end
end
