class EventAttendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  # TODO - add on-create callback that sets the RSVP date (?)
end
