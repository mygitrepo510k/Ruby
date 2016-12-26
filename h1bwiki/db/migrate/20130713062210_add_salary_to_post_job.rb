class AddSalaryToPostJob < ActiveRecord::Migration
  def change
    add_column :post_jobs, :salary, :string
    add_column :post_jobs, :hourly_rate, :string
  end
end
