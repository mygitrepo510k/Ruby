class AddPlayerAndWistiaIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :wistia_id, :string
    add_column :posts, :player_embed, :text
  end
end
