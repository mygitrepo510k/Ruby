class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :type
      t.datetime :date
      t.integer :activity_by_id
      t.integer :activity_with_id
      t.integer :company_id

      #t.timestamps
    end
    add_index :activities, :activity_by_id
    add_index :activities, :activity_with_id
    add_index :activities, :company_id
  end
end
