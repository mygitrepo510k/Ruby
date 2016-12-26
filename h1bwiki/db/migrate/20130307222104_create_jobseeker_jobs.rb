class CreateJobseekerJobs < ActiveRecord::Migration
  def change
    create_table :jobseeker_jobs do |t|
      t.belongs_to :user
      t.string :title
      t.integer :transfer
      t.integer :status
      t.text :description

      t.timestamps
    end
    add_index :jobseeker_jobs, :user_id
  end
end
