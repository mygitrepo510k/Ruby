class CreateEventAttendees < ActiveRecord::Migration
  def change
    create_table :event_attendees do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.string :status
      t.datetime :rsvped
      t.integer :guest_count

      t.timestamps
    end
    add_index :event_attendees, [:user_id, :event_id], unique: true
  end
end
