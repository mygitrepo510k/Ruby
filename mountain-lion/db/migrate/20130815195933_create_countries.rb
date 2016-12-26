class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :code, limit: 2
      t.string :name

      t.timestamps
    end
    add_index :countries, :code, unique: true
    add_index :countries, :name, unique: true
  end
end
