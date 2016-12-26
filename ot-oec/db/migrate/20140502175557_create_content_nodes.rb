class CreateContentNodes < ActiveRecord::Migration
	def change
		create_table :content_nodes do |t|
			t.integer :parent_id
			t.string :name

			t.timestamps
		end

		add_column :programs, :root_content_node_id, :integer

		create_table :content_groups_content_nodes, id: false do |t|
			t.integer :content_group_id, index: true
			t.integer :content_node_id, index: true
		end
	end

end
