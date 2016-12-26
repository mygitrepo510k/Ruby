class AddCreatedForToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :created_for_id, :integer
  end
end
