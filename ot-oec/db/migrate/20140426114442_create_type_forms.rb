class CreateTypeForms < ActiveRecord::Migration
	def change
		create_table :type_forms do |t|
			t.references :user_programs, index: true
			t.integer :typeform_id
			t.text :response

			t.timestamps
		end
	end
end
