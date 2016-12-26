class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.references :user
      t.references :contact
      t.boolean :connected, :default => false
      t.timestamps
    end

    add_index :user_contacts, :user_id
    add_index :user_contacts, :contact_id
  end
end
