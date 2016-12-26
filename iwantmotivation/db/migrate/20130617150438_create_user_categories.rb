class CreateUserCategories < ActiveRecord::Migration
  def change
    create_table :user_categories do |t|
      t.belongs_to :user
      t.belongs_to :category

      t.timestamps
    end
    add_index :user_categories, :user_id
    add_index :user_categories, :category_id
  end
end
