class AddMissingIndexesOptimization < ActiveRecord::Migration
  def change
    add_index :users, [:type, :active]
    add_index :users, [:type, :username]
    add_index :users, [:type, :last_logout_at]
  end
end
