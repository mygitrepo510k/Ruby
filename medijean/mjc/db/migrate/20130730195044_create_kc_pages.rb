class CreateKcPages < ActiveRecord::Migration
  def change
    create_table :kc_pages do |t|
      t.string :title
      t.string :url
      t.text :html
      t.integer :sort_order
      t.boolean :published

      t.timestamps
    end
  end
end
