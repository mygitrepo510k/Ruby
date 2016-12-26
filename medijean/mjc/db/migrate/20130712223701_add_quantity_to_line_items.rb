class AddQuantityToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :quantity, :integer
    add_column :line_items, :unit, :integer
  end
end
