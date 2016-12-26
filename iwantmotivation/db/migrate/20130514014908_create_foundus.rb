class CreateFoundus < ActiveRecord::Migration
  def change
    create_table :foundus do |t|
      t.string :found_us_name

      t.timestamps
    end
  end
end
