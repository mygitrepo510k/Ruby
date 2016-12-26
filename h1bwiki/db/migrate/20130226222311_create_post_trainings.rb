class CreatePostTrainings < ActiveRecord::Migration
  def change
    create_table :post_trainings do |t|
      t.belongs_to :user
      t.string :job_title
      t.integer :job_technology
      t.integer :job_instruction
      t.string :job_placement
      t.string :job_accomodation
      t.string :job_city      #add field
      t.string :job_state     #add field
      t.string :job_duration
      t.text :job_description

      t.timestamps
    end
    add_index :post_trainings, :user_id
  end
end
