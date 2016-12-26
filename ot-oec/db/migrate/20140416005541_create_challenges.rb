class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.string :description
      t.integer :created_by_id
      t.integer :cover_id
      t.belongs_to :program

      t.timestamps
    end
  end
end
