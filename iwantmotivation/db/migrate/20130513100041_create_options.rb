class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_name
      t.text :option_value

      t.timestamps
    end
  end
end
