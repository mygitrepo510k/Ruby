class AddUnsubscribeTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unsubscribe_token, :string
    add_column :user_settings, :unsubscribed, :boolean, default: false

    ActiveRecord::Base.transaction do
      User.all.each { |u| u.update_attribute(:unsubscribe_token, TokenGenerator.generate_random_token) }
    end
  end
end
