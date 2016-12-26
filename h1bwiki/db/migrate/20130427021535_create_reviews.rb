class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :h1bemp
      t.belongs_to :user
      t.string :paidontime
      t.string :placement
      t.string :legal

      t.timestamps
    end
    add_index :reviews, :h1bemp_id
    add_index :reviews, :user_id
  end
end
