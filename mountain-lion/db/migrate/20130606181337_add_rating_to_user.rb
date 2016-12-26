class AddRatingToUser < ActiveRecord::Migration
  def change
    add_column :users, :rating, :integer, default: 1
  end
end
