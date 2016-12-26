class AddAdminToRole < ActiveRecord::Migration
  def change
    add_column :roles, :admin, :boolean
  end
end
