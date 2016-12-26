class ExtendUrlFieldLengthInContent < ActiveRecord::Migration
	def change
		change_column :contents, :url, :text
	end
end
