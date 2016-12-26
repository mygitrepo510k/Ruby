class AddDeletedFieldToTables < ActiveRecord::Migration
  def change
    add_column :challenges, :deleted, :boolean, default: false
    add_column :comments, :deleted, :boolean, default: false
    add_column :content_groups, :deleted, :boolean, default: false
    add_column :contents, :deleted, :boolean, default: false
    add_column :events, :deleted, :boolean, default: false
    add_column :experiences, :deleted, :boolean, default: false
    add_column :pods, :deleted, :boolean, default: false
    add_column :posts, :deleted, :boolean, default: false
    add_column :programs, :deleted, :boolean, default: false
    add_column :users, :deleted, :boolean, default: false
  end
end
