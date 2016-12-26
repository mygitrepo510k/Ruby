class AddScopeToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :program, index: true
    add_column :comments, :scope, :string
  end
end
