class AddOptionAndMonthToContents < ActiveRecord::Migration
  def change
    add_column :contents, :option, :string
    add_column :contents, :month, :integer
  end
end
