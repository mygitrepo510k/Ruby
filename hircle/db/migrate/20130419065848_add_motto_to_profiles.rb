class AddMottoToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :motto, :string
  end
end
