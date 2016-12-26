class AddResourceIdToAttaches < ActiveRecord::Migration
  def change
    add_column :attaches, :resource_id, :integer
  end
end
