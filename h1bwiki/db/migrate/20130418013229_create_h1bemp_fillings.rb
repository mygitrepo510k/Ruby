class CreateH1bempFillings < ActiveRecord::Migration
  def change
    create_table :h1bemp_fillings do |t|
      t.belongs_to :h1bemp
      t.string :filingtype
      t.string :filingyear
      t.string :filingstatus
      t.string :filingcount

      t.timestamps
    end
    add_index :h1bemp_fillings, :h1bemp_id
  end
end
