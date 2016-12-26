class CreatePosts < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.text :body
			t.belongs_to :program, index: true

			t.timestamps
		end
	end
end
