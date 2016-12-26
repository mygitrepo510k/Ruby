class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.string :sender_type
      t.integer :sender_id
      t.string :receiver_type
      t.integer :receiver_id
      t.integer :contract_id
      t.float :debit
      t.float :credit
      t.string :transaction_foreign_id

      t.timestamps
    end
  end
end
