class CleanupCitiesAndStates < ActiveRecord::Migration
  def change
    remove_index :cities, :state_id
    remove_column :cities, :state_id
    remove_column :cities, :geoname_id

    remove_column :states, :geoname_id
  end
end
