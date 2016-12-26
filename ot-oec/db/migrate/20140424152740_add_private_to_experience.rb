class AddPrivateToExperience < ActiveRecord::Migration
	def change
		add_column :experiences, :private, :boolean
	end
end
