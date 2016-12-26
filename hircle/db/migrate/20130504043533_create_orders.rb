class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :card_expires_on
      t.string :card_type
      t.string :first_name
      t.string :ip_address
      t.string :last_name
      t.string :card_number
      t.date :card_verification

      t.timestamps
    end
  end
end
