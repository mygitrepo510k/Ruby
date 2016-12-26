class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string  :title
      t.text    :description
      t.string  :city
      t.string  :state
      t.integer :zip
      t.string  :field
      t.string  :tag
      t.integer :visibility
      t.attachment :logo     

      t.timestamps
    end 
    
  end
end
