class RemoveOtherSymptonFromPrescriptions < ActiveRecord::Migration
  def up
    remove_column :prescriptions, :other_symptom
  end

  def down
    add_column :prescriptions, :other_symptom, :string
  end
end
