class DropItems < ActiveRecord::Migration
  def change
    drop_table :items
    rename_column :line_items, :item_id, :medicine_id
  end
end
