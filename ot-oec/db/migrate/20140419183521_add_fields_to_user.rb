class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :tagline, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :job, :string
  end
end
