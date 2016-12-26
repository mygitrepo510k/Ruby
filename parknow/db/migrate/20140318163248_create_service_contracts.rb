class CreateServiceContracts < ActiveRecord::Migration
  def change
    create_table :service_contracts do |t|
      t.datetime :parked_at
      t.datetime :departed_at
      t.belongs_to :service_offer, index: true
      t.belongs_to :service_request, index: true
      t.string :state

      t.timestamps
    end
  end
end
