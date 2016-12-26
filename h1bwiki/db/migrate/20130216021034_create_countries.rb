class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :name
      t.string :iso_code_2
      t.string :iso_code_3
      t.string :address_format
      t.string :postcode
      t.integer :status

      t.timestamps
    end
  end
end
