class CreateVendorTerms < ActiveRecord::Migration
  def change
    create_table :vendor_terms do |t|
      t.belongs_to :vendor, index: true
      t.boolean :enabled
      t.float :hourly_rate
      t.float :max_hourly_hours
      t.float :flat_rate
      t.float :max_flat_hours

      t.timestamps
    end
  end
end
