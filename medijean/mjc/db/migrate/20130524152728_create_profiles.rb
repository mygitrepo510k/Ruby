class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :health_card_number
      t.string :phone
      t.date :date_of_birth

      t.timestamps
    end
  end
end
