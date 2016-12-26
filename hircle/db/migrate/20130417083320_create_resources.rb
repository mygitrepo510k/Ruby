class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :label
      t.string :pointer
      t.string :resource_type
      t.string :attach_content_type
      t.string :attach_file_name
      t.integer :attach_file_size
      t.integer :company_id
      t.integer :user_id
      t.datetime :update_at

      #t.timestamps
    end
  end
end
