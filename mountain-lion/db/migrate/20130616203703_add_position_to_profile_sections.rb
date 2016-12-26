class AddPositionToProfileSections < ActiveRecord::Migration
  def change
    add_column :profile_sections, :position, :integer
  end
end
