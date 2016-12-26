class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.belongs_to :user
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :website
      t.string :sp_transfer
      t.string :everified
      t.string :training_provided
      t.string :accommodation
      t.text :description

      t.timestamps
    end
  end
end
