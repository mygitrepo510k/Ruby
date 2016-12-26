class AddMadePrivateToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :made_private, :boolean, default: false
  end
end
