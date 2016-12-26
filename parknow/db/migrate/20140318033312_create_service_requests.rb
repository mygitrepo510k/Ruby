class CreateServiceRequests < ActiveRecord::Migration
  def change
    create_table :service_requests do |t|
      t.string :creation_date
      t.belongs_to :customer, index: true
      t.belongs_to :vehicle, index: true
      t.string :address
      t.string :location
      t.float :latitude
      t.float :longitude
      t.datetime :expiry
      t.text :client_guid

      t.timestamps
    end
  end
end
