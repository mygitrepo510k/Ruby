class AddPhoneAndWebSiteToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :phone, :string
    add_column :doctors, :fax, :string
    add_column :doctors, :email, :string
    add_column :doctors, :web_site, :string
  end
end
