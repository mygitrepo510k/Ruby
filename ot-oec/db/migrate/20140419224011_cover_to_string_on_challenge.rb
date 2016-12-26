class CoverToStringOnChallenge < ActiveRecord::Migration
	def change
		remove_column :challenges, :cover_id
		add_column :challenges, :cover, :string
	end
end
