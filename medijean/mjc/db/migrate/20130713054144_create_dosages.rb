class CreateDosages < ActiveRecord::Migration
  def change
    create_table :dosages do |t|
      t.integer :quantity
      t.integer :unit
      t.integer :frequency

      t.timestamps
    end
  end
end
