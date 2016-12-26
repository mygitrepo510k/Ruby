class AddPinnedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :pinned, :boolean, default: false
  end
end
