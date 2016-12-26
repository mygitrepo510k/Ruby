class AddAttachmentPrescriptionImageToPrescriptions < ActiveRecord::Migration
  def self.up
    change_table :prescriptions do |t|
      t.attachment :prescription_image
    end
  end

  def self.down
    drop_attached_file :prescriptions, :prescription_image
  end
end
