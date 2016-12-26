class AddFrameToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :frame_id, :integer
  end
end
