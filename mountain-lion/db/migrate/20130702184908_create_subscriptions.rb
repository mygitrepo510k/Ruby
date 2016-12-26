class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.decimal :member_id
      t.decimal :trans_id
      t.string :auth_code
      t.datetime :auth_date
      t.string :auth_msg
      t.decimal :recurring_id
      t.string :avs_code
      t.string :cvv2_code
      t.decimal :settle_amount, precision: 10, scale: 2
      t.string :settle_currency
      t.string :processor
      t.boolean :active
      t.references :user, index: true

      t.timestamps
    end
  end
end
