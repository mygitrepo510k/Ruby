class AddFieldsToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :looking_to_open, :text
    add_column :experiences, :process, :text
    add_column :experiences, :possible_difficulties, :text
    add_column :experiences, :how_to_handle, :text
    remove_column :experiences, :description
  end
end
