class CreateScoutListings < ActiveRecord::Migration
  def change
    create_table :scout_listings do |t|
      t.integer :user_id
      t.timestamp :timestamp
      t.boolean :call
      t.boolean :drive
      t.string :tags
      t.integer :max-budget
      t.integer :beds
      t.integer :baths
      t.date :move-in-date
      t.text :notes

      t.timestamps
    end
  end
end
