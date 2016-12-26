class Removefields1Prescription < ActiveRecord::Migration
  def change
    remove_column :prescriptions, :current_ingestion_method
  end
end
