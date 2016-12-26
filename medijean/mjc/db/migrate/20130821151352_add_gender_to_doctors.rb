class AddGenderToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :gender, :integer
  end
end
