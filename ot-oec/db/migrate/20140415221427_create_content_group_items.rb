class CreateContentGroupItems < ActiveRecord::Migration
  def change
    create_table :content_group_items do |t|
      t.belongs_to :content_group
      t.belongs_to :content

      t.timestamps
    end
    add_index :content_group_items, [:content_group_id, :content_id], unique: true
  end
end
