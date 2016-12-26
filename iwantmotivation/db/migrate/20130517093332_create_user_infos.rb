class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.belongs_to :user
      t.integer :age
      t.string :country
      t.string :state
      t.string :city
      t.string :discount_code
      t.text :motivational_partner
      t.text :philosophy_on_life
      t.text :my_story
      t.text :books_enjoyed
      t.text :other_groups
      t.text :groups_belong_to

      t.timestamps
    end
    add_index :user_infos, :user_id
  end
end
