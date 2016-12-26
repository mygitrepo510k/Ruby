class AddBumpedDateToPost < ActiveRecord::Migration
  def change
    add_column :posts, :bumped, :datetime
  end
end
