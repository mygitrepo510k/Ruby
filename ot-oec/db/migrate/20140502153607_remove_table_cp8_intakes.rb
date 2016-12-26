class RemoveTableCp8Intakes < ActiveRecord::Migration
	def change
		drop_table :cp8_intakes
	end
end
