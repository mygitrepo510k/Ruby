class AddResponseIdToTypeForms < ActiveRecord::Migration
  def change
    add_column :type_forms, :response_id, :integer
  end
end
