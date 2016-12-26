class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.string :subject
      t.text :body
      t.belongs_to :program, index: true
      t.integer :created_by_id
      t.boolean :hidden, default: false

      t.timestamps
    end
  end
end
