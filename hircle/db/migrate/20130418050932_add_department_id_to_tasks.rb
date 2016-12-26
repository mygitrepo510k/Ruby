class AddDepartmentIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :department_id, :integer
  end
end
