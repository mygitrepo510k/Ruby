class RenameTypeColumnFromActivities < ActiveRecord::Migration
   def self.up
    rename_column :activities, :type, :activity_type
  end

  def down
  end
end
