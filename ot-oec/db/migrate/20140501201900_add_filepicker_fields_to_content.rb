class AddFilepickerFieldsToContent < ActiveRecord::Migration
  def change
    add_column :contents, :filepicker_url, :string
    add_column :contents, :s3_key, :string
  end
end
