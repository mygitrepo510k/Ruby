class AddS3KeyToPost < ActiveRecord::Migration
  def change
    add_column :posts, :s3_key, :string
  end
end
