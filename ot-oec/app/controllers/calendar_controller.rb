class CalendarController < ApplicationController
  before_filter :require_login

  def index
    common_layout_support
  end

  def get_events
    start_at = Time.at(params['start'].to_i).to_formatted_s(:db)
    end_at = Time.at(params['end'].to_i).to_formatted_s(:db)
    @events = Event.where("start >= '#{start_at}' and start <= '#{end_at}'").where(program: current_user.current_program)
    @experiences = Experience
      .where("(scheduled_for >= '#{start_at}' or executed_at >= '#{start_at}') and (scheduled_for <= '#{end_at}' or executed_at <= '#{end_at}')")
      .where(program: current_user.current_program)

    events = [] 
    @events.each do |event|
      events << {:id => event.id, 
        :title => event.name, 
        :description => event.description || "Some cool description here...", 
        :start => "#{event.start.iso8601}", 
        :end => "#{event.end.iso8601}", 
        :allDay => event.all_day,
        :tip =>"
        <div style='width: 250px;'>
        <label style='font-size:16px; color: white;'>#{event.name}</label><br/>
        <label style='width: 70px;'>When: </label> <span style='font-size:12px;'>#{event.duration}</span> <br/>
        <label style='width: 70px;'>Where: </label> <span style='font-size:12px;'>#{event.place_name}</span> <br/>
        <label style='width: 70px;'>Description:</label> <span style='font-size:12px;'>#{event.description}</span>
        <div>
        ",
        :type => 'event',
        :show_link => admin_event_path(event)
        #:recurring => (event.event_series_id)? true: false
      }
    end

    @experiences.each do |exp|
      if exp.created_for.student? and exp.executed_by.present?
        events << {:id => exp.id, 
            :title => exp.name, 
            :description => exp.looking_to_open, 
            :start => "#{exp.executed_at.iso8601}", 
            :end => "#{exp.executed_at.iso8601}", 
            :allDay => true,
            :type => "experience",
            :mark => "executed",
            :show_link => experience_path(exp)
          }  
      else
        if exp.executed_by.present?
          st_at = exp.executed_at.iso8601
          ed_at = exp.executed_at.iso8601
          mark = "executed"
        else
          st_at = exp.scheduled_for.iso8601
          ed_at = exp.scheduled_for.iso8601
          mark = "not-executed"
        end
        events << {:id => exp.id, 
            :title => exp.name, 
            :description => exp.looking_to_open, 
            :start => "#{st_at}", 
            :end => "#{ed_at}",
            :allDay => true,
            :type => "experience",
            :mark => mark,
            :show_link => experience_path(exp)
          }
      end      
    end

    render :text => events.to_json
  end

end
