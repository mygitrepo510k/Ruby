class CreateSpaceUsers  < ActiveRecord::Migration
  def self.up  
    create_table :spaces_users do |t|
      t.references :users, :spaces
   
    end
  end

  def self.down
    drop_table :spaces_users
  end

 # add_index:space_users, [:user_id,:space_id], :unique => true
  
end# To change this template, choose Tools | Templates
# and open the template in the editor.
