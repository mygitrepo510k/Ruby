class AddTotalsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :sub_total, :decimal
    add_column :orders, :tax, :decimal
    add_column :orders, :taxname, :string
    add_column :orders, :total, :decimal
    add_column :orders, :shipping_address_id, :integer
    add_column :orders, :user_id, :integer
  end
end
