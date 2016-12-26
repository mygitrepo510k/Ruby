class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :user
      t.string :name
      t.float :balance
      t.float :available_balance

      t.timestamps
    end
  end
end
