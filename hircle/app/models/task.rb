class Task < ActiveRecord::Base

  attr_accessible  :document,:assignor_id, :company_id, :description, :due_date, :priority, :resource_id, :start_date, :status, :title, :department_id,
  :document_content_type, :document_file_name, :document_file_size

  attr_accessor :document_content_type, :document_file_name, :document_file_size

  #support multiple types
  has_attached_file :document,
  :styles => lambda{ |a|
    ["image/jpeg", "image/png", "image/jpg", "image/gif"].include?( a.content_type ) ? {
      :thumb=> "100x100#",
      :small  => "150x150>",
      :medium => "300x300>" }: {}
    }
    #:styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"                

    #has_many :users, :through => :tasks_users
    has_and_belongs_to_many :users
    belongs_to :department

    has_many :assignments
    belongs_to :assignor, :class_name => "User",:foreign_key => "user_id"

    scope :between, lambda { |start_time, end_time|  
      {:conditions => ["? < start_date < ?", Task.format_date(start_time), Task.format_date(end_time)] }  
    }  

    def self.format_date(date_time)  
      Time.at(date_time.to_i).to_formatted_s(:db)  
    end 


    def as_json(options = {})  
      {  
        :id => self.id,  
        :title => self.title,  
        :description => self.description || "",  
        :start => start_date.rfc822,  
        :end => due_date.rfc822,  
        #:allDay => self.all_day,  
        :recurring => false,  
        :url => Rails.application.routes.url_helpers.task_path(id),  
      }  
    end 

  end
