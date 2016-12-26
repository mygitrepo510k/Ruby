class AddWistiaIdToContent < ActiveRecord::Migration
  def change
    add_column :contents, :wistia_id, :string
  end
end
