class CreateVendorUsers < ActiveRecord::Migration
  def change
    create_table :vendor_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :vendor, index: true
      t.string :name

      t.timestamps
    end
  end
end
