class ChangeWelcomeEmailToText < ActiveRecord::Migration
	def change
		change_column :programs, :welcome_email, :text
	end
end
