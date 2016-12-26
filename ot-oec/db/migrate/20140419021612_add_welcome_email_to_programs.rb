class AddWelcomeEmailToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :welcome_email, :string
  end
end
