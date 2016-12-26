class CreateMemberGroups < ActiveRecord::Migration
  def change
    create_table :member_groups do |t|
      t.belongs_to :group
      t.belongs_to :user

      t.timestamps
    end
    add_index :member_groups, :group_id
    add_index :member_groups, :user_id
  end
end
