class AddFormToTypeForms < ActiveRecord::Migration
	def change
		add_column :type_forms, :form, :string
	end
end
