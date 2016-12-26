class AddPhotoToProfile < ActiveRecord::Migration
  def self.up
    add_attachment :profiles, :photo
  end

  def self.down
    remove_attachment :profiles, :photo
  end
end
