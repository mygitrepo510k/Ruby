class CreatePostMentors < ActiveRecord::Migration
  def change
    create_table :post_mentors do |t|
      t.belongs_to :user
      t.string :job_title
      t.string :job_interview
      t.text :job_description

      t.timestamps
    end
    add_index :post_mentors, :user_id
  end
end
