class AddAutoRenewToPaymentProfile < ActiveRecord::Migration
  def change
    add_column :payment_profiles, :auto_renew, :boolean
  end
end
