class RenameWebsiteColumnAtDoctors < ActiveRecord::Migration
  def change
    rename_column :doctors, :web_site, :website
  end
end
