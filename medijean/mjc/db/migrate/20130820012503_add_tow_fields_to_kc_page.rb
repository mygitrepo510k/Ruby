class AddTowFieldsToKcPage < ActiveRecord::Migration
  def change
    add_column :kc_pages, :visible_to_doctors, :boolean
    add_column :kc_pages, :visible_to_patients, :boolean
  end  
end
