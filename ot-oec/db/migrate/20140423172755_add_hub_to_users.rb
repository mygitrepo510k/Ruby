class AddHubToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hub, :text
  end
end
