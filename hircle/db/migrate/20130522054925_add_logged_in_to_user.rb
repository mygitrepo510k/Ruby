class AddLoggedInToUser < ActiveRecord::Migration
 	def change
    add_column :users, :logged_in, :boolean, :default => false
  end
end
