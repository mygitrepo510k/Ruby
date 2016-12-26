class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.belongs_to :user
      t.string :name
      t.string :address
      t.string :location
      t.float :latitude
      t.float :longitude
      t.text :description

      t.timestamps
    end
  end
end
