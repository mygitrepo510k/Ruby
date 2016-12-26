class AddByToPost < ActiveRecord::Migration
  def change
    add_column :posts, :by_id, :integer
  end
end
