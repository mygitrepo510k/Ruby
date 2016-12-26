class AddHealthCardNumberAndInvitationTokenToDoctorPatients < ActiveRecord::Migration
  def change
    add_column :doctor_patients, :health_card_number, :string
    add_column :doctor_patients, :invitation_token, :string
  end
end
