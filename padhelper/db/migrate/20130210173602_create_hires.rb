class CreateHires < ActiveRecord::Migration
  def change
    create_table :hires do |t|
      t.integer :user_id
      t.integer :hired_helper_id
      t.integer :hiring_user_id

      t.timestamps
    end
  end
end
