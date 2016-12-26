class RemoveDbLevelUniqueIndexesOnSomeModels < ActiveRecord::Migration
  def change
    remove_index :users, name: 'index_users_on_email'
    remove_index :users, name: 'index_users_on_hub_id'

    remove_index :programs, name: 'index_programs_on_hub_group_id'
  end
end
