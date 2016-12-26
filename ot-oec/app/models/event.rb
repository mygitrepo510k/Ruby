require 'abstract_base_model'
#require 'event_calendar'

class Event < SoftDeletedModel
	#has_event_calendar start_at_field: "start", end_at_field: "end" 
  belongs_to :program
  belongs_to :created_by, class_name: 'User'
  belongs_to :host, class_name: 'User'

  has_many :event_attendees
  has_many :users, through: :event_attendees

  has_many :comments, as: :commentable

  validates_presence_of :name, :description, :start, :end, :created_by_id

  def all_day
  	(self.end - self.start) > 86400 ? true : false
  end

  def duration
    duration = ""
    if self.start.year == self.end.year
      if self.start.month == self.end.month
        if self.start.day == self.end.day
          duration = self.start.strftime("%a, %b %e, %H:%p") + " - " + self.end.strftime("%H:%p")
        else
          duration = self.start.strftime("%b %e, %H:%p") + " - " + self.end.strftime("%e, %H:%p")
        end
      else
        duration = self.start.strftime("%b %e, %H:%p") + " - " + self.end.strftime("%b %e, %H:%p")
      end
    end
  end
end
