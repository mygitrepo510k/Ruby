class AddStateIdAndCityIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :state_id, :integer
    add_column :users, :city_id, :integer
    add_index :users, [ :state_id, :city_id ]
  end
end
