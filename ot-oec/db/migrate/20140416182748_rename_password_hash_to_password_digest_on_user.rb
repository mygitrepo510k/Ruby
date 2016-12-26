class RenamePasswordHashToPasswordDigestOnUser < ActiveRecord::Migration
  def change
    remove_column :users, :password_hash, :string
    add_column :users, :password_digest, :string
  end
end
