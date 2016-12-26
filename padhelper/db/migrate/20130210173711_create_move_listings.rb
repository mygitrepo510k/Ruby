class CreateMoveListings < ActiveRecord::Migration
  def change
    create_table :move_listings do |t|
      t.integer :user_id
      t.timestamp :timestamp
      t.string :start-address
      t.string :end-address
      t.boolean :packing
      t.string :move-type
      t.text :notes

      t.timestamps
    end
  end
end
