class AddReferralAmountToPostJobs < ActiveRecord::Migration
  def change
    add_column :post_jobs, :referral_amount, :integer
  end
end
