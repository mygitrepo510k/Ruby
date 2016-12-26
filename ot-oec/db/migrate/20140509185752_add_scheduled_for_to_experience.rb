class AddScheduledForToExperience < ActiveRecord::Migration
  def change
    add_column :experiences, :scheduled_for, :datetime
  end
end
