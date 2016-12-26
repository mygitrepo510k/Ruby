class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.belongs_to :category
      t.string :title
      t.string :author
      t.decimal :price, :precision=>8, :scale=>2, :default => "0"
      t.decimal :sell_price, :precision=>8, :scale=>2, :default => "0"      
      t.text :content
      t.text :affiliate_code
      t.timestamps
    end
    add_index :stores, :category_id
  end
end
