class SpaceChangeColumn < ActiveRecord::Migration
  def change

    change_column :spaces, :name, :string, :null => false
    change_column :spaces, :company_id, :integer, :null => false
    change_column :spaces, :creator_id, :integer, :null => false
    
  end
end
