class ChildProfileActivity
  include Mongoid::Document
  include Mongoid::Timestamps
  field	 :title,                :type => String
  field	 :start_date,           :type => Date
  field	 :start_time,           :type => String
  field	 :repeats_every,        :type => DateTime
  field	 :repeats_start,        :type => String
  field	 :start_on_time,        :type => DateTime
  field	 :end_date,             :type => Date
  field	 :end_time,             :type => String
  field	 :start_on,             :type => Date
  field	 :repeats,              :type => String
  field	 :description,          :type => String
  field	 :school_activity,      :type => Boolean
  field	 :day_activity,         :type => Boolean
  field	 :ends_on,              :type => Boolean
  field	 :repeat_activity,      :type => Boolean
  field	 :add_to_timeline,      :type => Boolean
  field	 :start_time,           :type => String
  field	 :category,             :type => String
  field	 :subject,              :type => String
  field	 :type,                 :type => String
  field	 :repeats_on,           :type => Boolean
  field	 :role_participant,     :type => Boolean
  field	 :role_organizer,       :type => Boolean
  field	 :role_captain,         :type => Boolean
  field	 :role_anchor,          :type => Boolean
  field	 :repeats_onM,          :type => Boolean
  field	 :repeats_onT,          :type => Boolean
  field	 :repeats_onW,          :type => Boolean
  field	 :repeats_onTt,         :type => Boolean
  field	 :repeats_onF,          :type => Boolean
  field	 :repeats_onS,          :type => Boolean
  field	 :repeats_onSs,         :type => Boolean
  field	 :level,                :type => String
  field	 :team_activity,        :type => Boolean
  field	 :competitive,          :type => Boolean
  field	 :child_role,           :type => String
  field	 :importance,           :type => String
  field	 :outcome,              :type => String
  field	 :details,              :type => String

  validates :title, :start_date, :end_date, :presence => true

  belongs_to :family_member
  has_many :child_activity_outcomes,  :dependent => :destroy 
end