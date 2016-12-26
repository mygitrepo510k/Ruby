class AddPriceToMedicine < ActiveRecord::Migration
  def change
    add_column :medicines, :price, :decimal
  end
end
