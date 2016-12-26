class AddPlayerEmbedToContent < ActiveRecord::Migration
  def change
    add_column :contents, :player_embed, :text
  end
end
