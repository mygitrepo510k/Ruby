class LineItemShouldBeAOneToNRelationship < ActiveRecord::Migration
  def change
    drop_table :line_items_orders
    add_column :line_items, :order_id, :integer
  end
end
