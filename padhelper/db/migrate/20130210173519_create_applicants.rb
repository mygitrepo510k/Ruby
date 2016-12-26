class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.integer :move_listing_id
      t.integer :scout_listing_id
      t.integer :applicant_id

      t.timestamps
    end
  end
end
