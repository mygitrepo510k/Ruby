class AddPodToUserProgram < ActiveRecord::Migration
  def change
    add_column :user_programs, :pod_id, :integer
  end
end
