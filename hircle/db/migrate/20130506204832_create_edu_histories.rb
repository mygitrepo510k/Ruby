class CreateEduHistories < ActiveRecord::Migration
  def change
    create_table :edu_histories do |t|
      t.string :school_name
      t.string :city
      t.string :state
      t.datetime :start_date
      t.datetime :end_date
      t.string :program

      t.timestamps
    end
  end
end
