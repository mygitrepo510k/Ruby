class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.string :name
      t.integer :address_id
      t.string :phone
      t.string :fax

      t.timestamps
    end
  end
end
