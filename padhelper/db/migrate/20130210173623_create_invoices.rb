class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.timestamp :timestamp
      t.string :status
      t.integer :amount
      t.string :from-id
      t.string :to-id

      t.timestamps
    end
  end
end
