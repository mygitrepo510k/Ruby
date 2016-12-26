class CreateSocialAuthentications < ActiveRecord::Migration
  def change
    create_table :social_authentications do |t|
      t.integer :user_id
      t.string :user_name
      t.string :uid
      t.string :provider
      t.timestamps
    end
  end
end
