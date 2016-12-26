class ChangeTypeOfDoctorsPhysicianIdToString < ActiveRecord::Migration
  def up
    change_column :doctors, :physician_id, :string
  end

  def down
    change_column :doctors, :physician_id, :integer
  end
end
