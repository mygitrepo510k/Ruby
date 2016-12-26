class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :role
    	t.integer :invitation_id
    	t.integer :invitation_limit

      t.timestamps
    end
  end
end
