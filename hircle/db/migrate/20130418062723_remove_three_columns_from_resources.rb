class RemoveThreeColumnsFromResources < ActiveRecord::Migration
  def up
    remove_column :resources, :attach_content_type
    remove_column :resources, :attach_file_name
    remove_column :resources, :attach_file_size
  end

  def down
    add_column :resources, :attach_file_size, :integer
    add_column :resources, :attach_file_name, :string
    add_column :resources, :attach_content_type, :string
  end
end
