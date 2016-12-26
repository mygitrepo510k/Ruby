class AddExecutedAtToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :executed_at, :datetime
  end
end
