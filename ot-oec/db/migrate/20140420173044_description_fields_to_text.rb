class DescriptionFieldsToText < ActiveRecord::Migration
	def change
		change_column :challenges, :description, :text
		change_column :events, :place_name, :text
		add_column :events, :description, :text
	end
end
