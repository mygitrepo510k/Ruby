class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start
      t.datetime :end
      t.string :icon
      t.string :cover
      t.string :place_name
      t.string :place_id
      t.belongs_to :program
      t.integer :created_by_id

      t.timestamps
    end
  end
end
