class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.integer :search_city
      t.integer :search_state
      t.integer :search_zip_code
      t.integer :time_zone
      t.boolean :privacy, :default => true
      t.string  :username
      t.boolean :account_status, :default => true 
      
      t.timestamps
    end
  end
end
