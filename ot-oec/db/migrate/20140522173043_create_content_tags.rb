class CreateContentTags < ActiveRecord::Migration
  def change
    create_table :content_tags do |t|
      t.belongs_to :content, index: true
      t.belongs_to :tag, index: true

      t.timestamps
    end
  end
end
