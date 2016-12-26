class RenameDosageColumns < ActiveRecord::Migration
  def change
    rename_column :prescriptions, :dosage, :dosage_id
    rename_column :prescriptions, :current_dosage, :current_dosage_id
  end
end
