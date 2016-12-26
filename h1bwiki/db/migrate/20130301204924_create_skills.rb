class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.belongs_to :skill_list
      t.references :skillable, :polymorphic => true
      t.timestamps
    end
    add_index :skills, :skill_list_id
  end
end
