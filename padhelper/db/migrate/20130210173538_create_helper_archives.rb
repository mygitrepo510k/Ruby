class CreateHelperArchives < ActiveRecord::Migration
  def change
    create_table :helper_archives do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
