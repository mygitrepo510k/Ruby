class AddDurationTypeToPostJob < ActiveRecord::Migration
  def change
    add_column :post_jobs, :duration_type, :string
  end
end
