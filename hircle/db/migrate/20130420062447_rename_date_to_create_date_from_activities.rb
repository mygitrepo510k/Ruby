class RenameDateToCreateDateFromActivities < ActiveRecord::Migration
  def up
    rename_column :activities, :date, :create_date
  end

  def down
  end
end
