class AddCityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :city, :string, null: false
  end
end
