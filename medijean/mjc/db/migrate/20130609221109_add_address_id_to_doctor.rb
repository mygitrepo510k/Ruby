class AddAddressIdToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :address_id, :integer
  end
end
