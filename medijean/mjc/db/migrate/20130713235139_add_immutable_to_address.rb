class AddImmutableToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :immutable, :boolean
  end
end
