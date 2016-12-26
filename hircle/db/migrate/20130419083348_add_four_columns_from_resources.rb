class AddFourColumnsFromResources < ActiveRecord::Migration
  def change
    add_column :resources, :attach_content_type, :string
    add_column :resources, :attach_file_name, :string
    add_column :resources, :attach_file_size, :integer
    add_column :resources, :conversation_id, :integer
  end
end
