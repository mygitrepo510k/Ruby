class AddWelcomeEmailSubjectToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :welcome_email_subject, :string
  end
end
