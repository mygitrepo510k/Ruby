class AddStrainToPrescriptions < ActiveRecord::Migration
  def change
    add_column :prescriptions, :strain, :string
  end
end
