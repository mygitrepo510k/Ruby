class AddProfileUpdatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_updated, :boolean,:default=>false
  end
end
