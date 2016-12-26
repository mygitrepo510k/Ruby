class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.text :career_obj
      t.string :skills
      t.boolean :status

      t.timestamps
    end
  end
end
