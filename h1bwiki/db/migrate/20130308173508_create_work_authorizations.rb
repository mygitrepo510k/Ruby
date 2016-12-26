class CreateWorkAuthorizations < ActiveRecord::Migration
  def change
    create_table :work_authorizations do |t|
      t.belongs_to :post_job
      t.integer :workauthorization_index

      t.timestamps
    end
    add_index :work_authorizations, :post_job_id
  end
end
