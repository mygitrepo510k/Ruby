class AddAvatarColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_file_size, :integer
  end
end
