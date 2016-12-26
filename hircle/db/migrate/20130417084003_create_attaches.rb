class CreateAttaches < ActiveRecord::Migration
  def change
    create_table :attaches do |t|
      t.string :attach_content_type
      t.string :attach_file_name
      t.integer :attach_file_size
      t.integer :conversation_id

      #t.timestamps
    end
  end
end
