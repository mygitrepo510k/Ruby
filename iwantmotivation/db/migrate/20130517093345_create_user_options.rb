class CreateUserOptions < ActiveRecord::Migration
  def change
    create_table :user_options do |t|
      t.string :name
      t.string :parent_id

      t.timestamps
    end
  end
end
