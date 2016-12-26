class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :name
      t.integer :created_by_id
      t.string :type
      t.text :description
      t.string :url
      t.string :file

      t.timestamps
    end
  end
end
