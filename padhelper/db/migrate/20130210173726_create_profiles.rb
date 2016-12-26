class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :portrait
      t.string :email
      t.string :paypal-email
      t.string :address
      t.string :city
      t.string :state
      t.integer :rating
      t.integer :zip
      t.integer :helpers-hired
      t.integer :listings-posted
      t.integer :hourly-rate
      t.integer :completed-jobs
      t.integer :job-applications

      t.timestamps
    end
  end
end
