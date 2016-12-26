class CreateContentGroups < ActiveRecord::Migration
  def change
    create_table :content_groups do |t|
      t.string :name
      t.text :description
      t.integer :created_by_id

      t.timestamps
    end
  end
end
