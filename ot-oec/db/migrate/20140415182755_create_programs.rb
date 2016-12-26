class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.string :avatar
      t.date :start_date
      t.date :end_date
      t.integer :hub_group_id

      t.timestamps
    end
    add_index :programs, :hub_group_id, unique: true
  end
end
