class AddUnitToMedicine < ActiveRecord::Migration
  def change
    add_column :medicines, :unit, :integer
  end
end
