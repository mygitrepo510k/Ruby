class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.belongs_to :user
      t.belongs_to :post_job
      t.string :bid_sentence

      t.timestamps
    end
    add_index :applicants, :user_id
    add_index :applicants, :post_job_id
  end
end
