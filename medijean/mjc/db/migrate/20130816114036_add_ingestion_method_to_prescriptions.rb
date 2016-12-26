class AddIngestionMethodToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :current_ingestion_method, :string
  end
end
