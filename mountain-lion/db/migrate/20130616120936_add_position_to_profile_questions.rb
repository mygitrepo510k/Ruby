class AddPositionToProfileQuestions < ActiveRecord::Migration
  def change
    add_column :profile_questions, :position, :integer
  end
end
