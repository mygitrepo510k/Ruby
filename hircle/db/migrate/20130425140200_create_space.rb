class CreateSpace < ActiveRecord::Migration
  def self.up
    create_table :spaces do |t|
      t.string :name
      t.text :description
      t.integer :company_id
      t.integer :creator_id
      t.string :status
      t.datetime :create_date
      t.datetime :update_date
     
    end
    add_index:spaces,  :creator_id
    
  end
end# To change this template, choose Tools | Templates
# and open the template in the editor.


