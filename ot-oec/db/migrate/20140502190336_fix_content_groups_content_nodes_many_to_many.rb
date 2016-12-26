class FixContentGroupsContentNodesManyToMany < ActiveRecord::Migration
	def change
		drop_table :content_groups_content_nodes
		
		create_table :content_groups_nodes, id: false do |t|
			t.integer :content_group_id, index: true
			t.integer :content_node_id, index: true
		end
	end
end
