class AddDepartmentIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :department_id, :integer
  end
end
