class AddPaymentStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :payment_status, :integer
  end
end
