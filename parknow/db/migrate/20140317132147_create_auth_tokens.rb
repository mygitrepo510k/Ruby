class CreateAuthTokens < ActiveRecord::Migration
  def change
    create_table :auth_tokens do |t|
      t.belongs_to :user
      t.string :token
      t.string :device_id
      t.string :device_type
      t.string :app_type

      t.timestamps
    end
  end
end
