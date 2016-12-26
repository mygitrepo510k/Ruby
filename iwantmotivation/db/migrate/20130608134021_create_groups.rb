class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :title
      t.text :description
      t.boolean :ispublic
      t.string :moderator

      t.timestamps
    end
  end
end
