class CreatePostJobs < ActiveRecord::Migration
  def change
    create_table :post_jobs do |t|
      t.belongs_to :user
      t.string :job_title
      t.integer :job_type
      t.string :job_city        #add  2013-3-8
      t.string :job_state       #add  2013-3-8
      t.string :job_duration    #add  2013-3-8
      t.text :job_description

      t.timestamps
    end
    add_index :post_jobs, :user_id
  end
end
