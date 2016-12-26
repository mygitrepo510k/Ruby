class AddResponseFieldsToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :what_came_up, :text
    add_column :experiences, :color, :integer
    add_column :experiences, :emergent, :text
    add_column :experiences, :feel_seen, :integer
    add_column :experiences, :go_deeper, :text
  end
end
