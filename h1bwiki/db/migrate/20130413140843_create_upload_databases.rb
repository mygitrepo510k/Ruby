class CreateUploadDatabases < ActiveRecord::Migration
  def change
    create_table :upload_databases do |t|
      t.string :table_name
      t.text :data_content

      t.timestamps
    end
  end
end