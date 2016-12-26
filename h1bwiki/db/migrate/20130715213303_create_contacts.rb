class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.belongs_to :user
      t.string :name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
