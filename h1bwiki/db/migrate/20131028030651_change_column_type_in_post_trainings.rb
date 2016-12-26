class ChangeColumnTypeInPostTrainings < ActiveRecord::Migration
  def up
  	change_column :post_trainings, :job_technology, :string
  end

  def down
  end
end
