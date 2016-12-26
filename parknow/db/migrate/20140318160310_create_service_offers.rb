class CreateServiceOffers < ActiveRecord::Migration
  def change
    create_table :service_offers do |t|
      t.belongs_to :vendor, index: true
      t.belongs_to :vendor_terms, index: true
      t.belongs_to :service_request, index: true
      t.string :state

      t.timestamps
    end
  end
end
