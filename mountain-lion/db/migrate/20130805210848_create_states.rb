class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :country_code
      t.string :state_code
      t.string :name
      t.integer :geoname_id

      t.timestamps
    end
    add_index :states, [ :country_code, :state_code ]
  end
end
