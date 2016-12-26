class ChangeDisplayedInProfileSections < ActiveRecord::Migration
  def change
    rename_column :profile_sections, :displayed?, :displayed
  end
end
