class AddPhysicianIdToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :physician_id, :integer
  end
end
