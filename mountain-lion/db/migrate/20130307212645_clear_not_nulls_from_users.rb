class ClearNotNullsFromUsers < ActiveRecord::Migration
  def change
    change_column_null :users, :date_of_birth, true
    change_column_null :users, :gender, true
    change_column_null :users, :country, true
    change_column_null :users, :zip_code, true
    change_column_null :users, :city, true
  end
end
