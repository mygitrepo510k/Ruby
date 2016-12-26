class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.string :name
      t.text :description
      t.integer :created_by_id
      t.belongs_to :program

      t.timestamps
    end
  end
end
