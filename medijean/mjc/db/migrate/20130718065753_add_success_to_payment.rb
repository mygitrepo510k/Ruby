class AddSuccessToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :success, :boolean
  end
end
