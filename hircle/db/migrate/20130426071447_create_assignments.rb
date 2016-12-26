class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :assignee_id
      t.integer :task_id

      t.timestamps
    end
  end
end
