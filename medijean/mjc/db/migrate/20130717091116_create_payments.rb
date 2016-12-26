class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :order_id
      t.string :charge_id
      t.integer :operation
      t.text :message

      t.timestamps
    end
  end
end
