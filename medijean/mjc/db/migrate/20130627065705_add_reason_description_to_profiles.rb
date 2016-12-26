class AddReasonDescriptionToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :reason_description, :string
  end
end
