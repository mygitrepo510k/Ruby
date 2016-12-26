class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :phone
      t.string :website
      t.integer :address_id
    end
  end
end
