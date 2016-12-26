class AddAbuseFlagToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :abuse, :boolean, default: false
  end
end
