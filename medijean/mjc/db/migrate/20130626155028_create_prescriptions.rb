class CreatePrescriptions < ActiveRecord::Migration
  def change
    create_table :prescriptions do |t|
      t.text :description

      t.timestamps
    end
  end
end
