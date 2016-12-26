class CreateUserChallenges < ActiveRecord::Migration
  def change
    create_table :user_challenges do |t|
      t.datetime :completed
      t.text :note

      t.belongs_to :user
      t.belongs_to :challenge

      t.timestamps
    end
  end
end
