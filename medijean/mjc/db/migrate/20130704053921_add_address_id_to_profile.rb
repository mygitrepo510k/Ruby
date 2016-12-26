class AddAddressIdToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :address_id, :integer
  end
end
