class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :state_id
      t.datetime :placed_at

      t.timestamps
    end
  end
end
