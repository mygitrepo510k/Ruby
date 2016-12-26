class AddProgramToContent < ActiveRecord::Migration
  def change
    add_reference :contents, :program, index: true
  end
end
