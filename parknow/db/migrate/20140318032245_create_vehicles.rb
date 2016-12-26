class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :license_plate
      t.string :make
      t.string :model
      t.string :color
      t.belongs_to :customer, index: true

      t.timestamps
    end
  end
end
