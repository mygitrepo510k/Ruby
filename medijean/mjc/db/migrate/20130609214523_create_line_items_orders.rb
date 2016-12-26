class CreateLineItemsOrders < ActiveRecord::Migration
  def change
    create_table :line_items_orders, :id => false do |t|
      t.integer :line_item_id
      t.integer :order_id
    end
  end
end
