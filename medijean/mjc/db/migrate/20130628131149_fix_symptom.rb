class FixSymptom < ActiveRecord::Migration
  def up
  	rename_column :prescriptions, :sympton, :symptom
  end

  def down
  end
end
