class RenameTypeToContentTypeOnContent < ActiveRecord::Migration
  def change
  	rename_column :contents, :type, :content_type
  end
end
