class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :subdomain
      t.string :city
      t.string :state
      t.string :website
      t.integer :plan_id

      t.timestamps
    end
  end
end
