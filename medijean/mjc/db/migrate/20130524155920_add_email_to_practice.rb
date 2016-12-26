class AddEmailToPractice < ActiveRecord::Migration
  def change
    add_column :practices, :email, :string
  end
end
