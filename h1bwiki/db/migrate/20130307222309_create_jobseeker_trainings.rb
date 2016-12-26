class CreateJobseekerTrainings < ActiveRecord::Migration
  def change
    create_table :jobseeker_trainings do |t|
      t.belongs_to :user
      t.string :title
      t.integer :status
      t.integer :transfer
      t.string :technology
      t.integer :instruction_mod
      t.integer :accomodation
      t.text :description

      t.timestamps
    end
    add_index :jobseeker_trainings, :user_id
  end
end
