class AddOtherSymptomToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :other_symptom, :string
  end
end
