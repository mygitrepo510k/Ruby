class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :geoname_id
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :country_code
      t.string :state_code
      t.references :state, index: true

      t.timestamps
    end
    add_index :cities, [:country_code, :state_code]
  end
end
