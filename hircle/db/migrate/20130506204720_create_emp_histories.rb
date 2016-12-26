class CreateEmpHistories < ActiveRecord::Migration
  def change
    create_table :emp_histories do |t|
      t.string :company
      t.datetime :start_date
      t.datetime :end_date
      t.string :job_title
      t.text :job_desc

      t.timestamps
    end
  end
end
