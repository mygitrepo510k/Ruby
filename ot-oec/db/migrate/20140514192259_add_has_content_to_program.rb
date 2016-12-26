class AddHasContentToProgram < ActiveRecord::Migration
  def change
    add_column :programs, :has_content, :boolean, default: true
  end
end
