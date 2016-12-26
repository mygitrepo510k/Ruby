class AddUserIdToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :user_id, :integer
  end
end
