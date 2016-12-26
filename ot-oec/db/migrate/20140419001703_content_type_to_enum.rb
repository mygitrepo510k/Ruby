class ContentTypeToEnum < ActiveRecord::Migration
	def change
		# http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html
		remove_column :contents, :type
		add_column :contents, :type, :integer, default: 0
	end
end
