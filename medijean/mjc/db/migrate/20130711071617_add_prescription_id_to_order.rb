class AddPrescriptionIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :prescription_id, :integer
  end
end
