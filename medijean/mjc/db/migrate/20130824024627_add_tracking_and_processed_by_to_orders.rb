class AddTrackingAndProcessedByToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tracking_number, :string
    add_column :orders, :processed_by_id, :integer
  end
end
