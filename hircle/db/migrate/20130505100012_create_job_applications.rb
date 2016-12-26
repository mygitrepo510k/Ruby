class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.integer :user_id
      t.integer :job_id
      t.boolean :watch, :default => false
      t.boolean :like, :default => false      
      t.timestamps      
    end
  end
end
