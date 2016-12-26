class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag_type
      t.string :name
      t.integer :added_by_id

      t.timestamps
    end
  end
end
