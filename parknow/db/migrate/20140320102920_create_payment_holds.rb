class CreatePaymentHolds < ActiveRecord::Migration
  def change
    create_table :payment_holds do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :service_contract, index: true
      t.float :debit
      t.float :credit

      t.timestamps
    end
  end
end
