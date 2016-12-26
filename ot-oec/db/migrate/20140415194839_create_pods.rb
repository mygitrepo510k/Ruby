class CreatePods < ActiveRecord::Migration
  def change
    create_table :pods do |t|
      t.integer :leader_id
      t.belongs_to :program
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
