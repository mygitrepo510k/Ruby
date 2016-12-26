class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :users
      t.string :title
      t.text :about_me, limit: 500
      t.text :looking_for, limit: 500

      t.timestamps
    end
  end
end
