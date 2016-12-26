class CreateCoachcounselors < ActiveRecord::Migration
  def change
    create_table :coachcounselors do |t|
      t.belongs_to :user
      t.string :really_name
      t.text :philosophy
      t.text :experience
      t.text :helppeople
      t.text :license

      t.timestamps
    end
    add_index :coachcounselors, :user_id
  end
end
