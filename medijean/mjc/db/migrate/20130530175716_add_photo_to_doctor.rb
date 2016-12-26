class AddPhotoToDoctor < ActiveRecord::Migration
  def self.up
    add_attachment :doctors, :photo
  end

  def self.down
    remove_attachment :doctors, :photo
  end
end