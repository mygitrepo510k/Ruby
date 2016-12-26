class AddSignupAndUpgradeIpAddress < ActiveRecord::Migration
  def change
    add_column :users, :signup_ip_address, :string
    add_column :subscriptions, :upgrade_ip_address, :string
  end
end
