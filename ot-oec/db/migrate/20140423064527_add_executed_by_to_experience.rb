class AddExecutedByToExperience < ActiveRecord::Migration
	def change
		add_column :experiences, :executed_by_id, :integer
	end
end
