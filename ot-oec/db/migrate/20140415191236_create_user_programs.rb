class CreateUserPrograms < ActiveRecord::Migration
  def change
    create_table :user_programs do |t|
      t.belongs_to :user
      t.belongs_to :program
      t.string :role

      t.timestamps
    end
  end
end
