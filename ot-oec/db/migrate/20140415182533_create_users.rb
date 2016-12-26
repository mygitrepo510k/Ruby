class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.boolean :super_admin
      t.string :timezone
      t.text :bio
      t.string :avatar
      t.integer :hub_id
      t.datetime :last_login
      t.string :auth_token
      t.string :password_reset_token
      t.datetime :password_reset_sent_at

      t.timestamps
    end
    add_index :users, :hub_id, unique: true
  end
end
