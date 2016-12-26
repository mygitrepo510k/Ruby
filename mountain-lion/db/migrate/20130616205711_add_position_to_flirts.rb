class AddPositionToFlirts < ActiveRecord::Migration
  def change
    add_column :flirts, :position, :integer
  end
end
