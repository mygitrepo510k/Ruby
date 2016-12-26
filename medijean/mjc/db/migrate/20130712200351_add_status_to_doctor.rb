class AddStatusToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :status, :integer
  end
end
