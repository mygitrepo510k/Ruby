class CreateH1bempTopjobs < ActiveRecord::Migration
  def change
    create_table :h1bemp_topjobs do |t|
      t.belongs_to :h1bemp
      t.string :employertitle
      t.string :totalcount
      t.string :avgsalary
      t.string :flag
      t.string :rn

      t.timestamps
    end
    add_index :h1bemp_topjobs, :h1bemp_id
  end
end
