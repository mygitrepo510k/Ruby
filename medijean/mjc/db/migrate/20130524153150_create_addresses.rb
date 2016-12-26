class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :unit
      t.string :city
      t.string :province
      t.string :postal_code
      t.integer :country_id

      t.timestamps
    end
  end
end
