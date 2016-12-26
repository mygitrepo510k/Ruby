class ChangeDefaultApproved < ActiveRecord::Migration
  def change
    change_column :user_photos, :approved, :boolean, default: false
    change_column :profile_sections, :displayed, :boolean, default: false
  end
end
