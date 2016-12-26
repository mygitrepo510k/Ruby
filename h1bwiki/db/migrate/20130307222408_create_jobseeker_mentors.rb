class CreateJobseekerMentors < ActiveRecord::Migration
  def change
    create_table :jobseeker_mentors do |t|
      t.belongs_to :user
      t.string :title
      t.integer :support
      t.text :description

      t.timestamps
    end
    add_index :jobseeker_mentors, :user_id
  end
end
