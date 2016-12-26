class CalendarController < ApplicationController
	
	def parent_month
		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'parent'
		redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?  	
	end
	def parent_week
		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?
  	
	end
	def parent_day
		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'parent'
    redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?  	
	end
	def get_parent_data
		parent = selected_parent
		s_time = Time.at(params['start'].to_i).to_formatted_s(:db)
		e_time = Time.at(params['end'].to_i).to_formatted_s(:db)
		calendar_data = []

		parent.families.each do |family|
			family.family_members.each do |f_members|
				f_members.child_profile_exams.each do |cpe|
					if cpe.start_date.to_datetime >= s_time.to_datetime and cpe.end_date.to_datetime <= e_time.to_datetime
						(cpe.start_date..cpe.end_date).each do |dt|
							cpe.child_profile_exam_schedules.each do |cpes|
								if cpes.start_date == dt
									st_dt = DateTime.new(cpes.start_date.year,cpes.start_date.month,cpes.start_date.day, cpes.start_time.to_i,0,0)
									et_dt = DateTime.new(cpes.start_date.year,cpes.start_date.month,cpes.start_date.day, cpes.end_time.to_i,0,0)
									calendar_data<<{:id => cpes.id, 
															:title => cpe.title, 
															:description => cpes.description, 
															:start => "#{st_dt.iso8601}", 
															:end => "#{et_dt.iso8601}", 
															:allDay => false, 
															:recurring => false}	
								end
							end
						end
					end
				end
				f_members.assignments.each do |assignment|
					if assignment.due_date.to_datetime >= s_time.to_datetime and assignment.due_date.to_datetime <= e_time.to_datetime
							calendar_data<<{:id => assignment.id, 
													:title => assignment.title, 
													:description => assignment.description, 
													:start => "#{assignment.due_date.iso8601}", 
													:end => "#{assignment.due_date.iso8601}", 
													:allDay => true, 
													:recurring => false}	
						
					end
				end
				f_members.holidays.each do |holiday|
					if holiday.start_date.to_datetime >= s_time.to_datetime and holiday.end_date.to_datetime <= e_time.to_datetime
							calendar_data<<{:id => holiday.id, 
													:title => holiday.title, 
													:description => holiday.description, 
													:start => "#{holiday.start_date.iso8601}", 
													:end => "#{holiday.end_date.iso8601}", 
													:allDay => true, 
													:recurring => false}	
						
					end
				end
				f_members.child_profile_activities.each do |cpa|
					if cpa.start_date.to_datetime >= s_time.to_datetime and cpa.end_date.to_datetime <= e_time.to_datetime
						st_dt = DateTime.new(cpa.start_date.year,cpa.start_date.month,cpa.start_date.day, cpa.start_time.to_i, 0, 0)
						et_dt = DateTime.new(cpa.end_date.year,cpa.end_date.month,cpa.end_date.day, cpa.end_time.to_i, 0, 0)
						
						calendar_data<<{:id => cpa.id, 
													:title => cpa.title, 
													:description => cpa.description, 
													:start => "#{st_dt.iso8601}", 
													:end => "#{et_dt.iso8601}", 
													:allDay => true, 
													:recurring => false}	
					end
				end
			end
		end
		
		render :text => calendar_data.to_json
	end

	def month
		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'child'
		redirect_to root_url	if session[:selected_member_id].nil? and params[:id].nil?
		session[:selected_member_id] = params[:id] if params[:id].present?		
	end

	def week
		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'child'
		redirect_to root_url	if session[:selected_member_id].nil? and params[:id].nil?
		session[:selected_member_id] = params[:id] if params[:id].present?
	end

	def day
		@date =  params[:dt].present? ? DateTime.parse(params[:dt]) : DateTime.now

		session[:show_variable_home] = 'Calendar'
		session[:dashboard] = 'child'
		redirect_to root_url	if session[:selected_member_id].nil? and params[:id].nil?
		session[:selected_member_id] = params[:id] if params[:id].present?
	end

	def get_data
		s_time = Time.at(params['start'].to_i).to_formatted_s(:db)
		e_time = Time.at(params['end'].to_i).to_formatted_s(:db)
		calendar_data = []
		if params[:type].present?
			render :text=>params[:type].inspect and return
		else		
			selected_member.child_profile_exams.each do |cpe|
				if cpe.start_date.to_datetime >= s_time.to_datetime and cpe.end_date.to_datetime <= e_time.to_datetime
					(cpe.start_date..cpe.end_date).each do |dt|
						cpe.child_profile_exam_schedules.each do |cpes|
							if cpes.start_date == dt
								st_dt = DateTime.new(cpes.start_date.year,cpes.start_date.month,cpes.start_date.day, cpes.start_time.to_i,0,0)
								et_dt = DateTime.new(cpes.start_date.year,cpes.start_date.month,cpes.start_date.day, cpes.end_time.to_i,0,0)
								calendar_data<<{:id => cpes.id, 
														:title => cpe.title, 
														:description => cpes.description, 
														:start => "#{st_dt.iso8601}", 
														:end => "#{et_dt.iso8601}", 
														:allDay => false, 
														:recurring => false}	
							end
						end
					end
				end
			end
			selected_member.assignments.each do |assignment|
				if assignment.due_date.to_datetime >= s_time.to_datetime and assignment.due_date.to_datetime <= e_time.to_datetime
						calendar_data<<{:id => assignment.id, 
												:title => assignment.title, 
												:description => assignment.description, 
												:start => "#{assignment.due_date.iso8601}", 
												:end => "#{assignment.due_date.iso8601}", 
												:allDay => true, 
												:recurring => false}	
					
				end
			end
			selected_member.holidays.each do |holiday|
				if holiday.start_date.to_datetime >= s_time.to_datetime and holiday.end_date.to_datetime <= e_time.to_datetime
						calendar_data<<{:id => holiday.id, 
												:title => holiday.title, 
												:description => holiday.description, 
												:start => "#{holiday.start_date.iso8601}", 
												:end => "#{holiday.end_date.iso8601}", 
												:allDay => true, 
												:recurring => false}	
					
				end
			end			
			selected_member.child_profile_activities.each do |cpa|
				if cpa.start_date.to_datetime >= s_time.to_datetime and cpa.end_date.to_datetime <= e_time.to_datetime
					st_dt = DateTime.new(cpa.start_date.year,cpa.start_date.month,cpa.start_date.day, cpa.start_time.to_i, 0, 0)
					et_dt = DateTime.new(cpa.end_date.year,cpa.end_date.month,cpa.end_date.day, cpa.end_time.to_i, 0, 0)
					
					calendar_data<<{:id => cpa.id, 
												:title => cpa.title, 
												:description => cpa.description, 
												:start => "#{st_dt.iso8601}", 
												:end => "#{et_dt.iso8601}", 
												:allDay => true, 
												:recurring => false}	
				end
			end
		end
		render :text => calendar_data.to_json
	end


	def time_line
		
	end

	def time_line_data
		time_line_data = {}
		
		time_asset={}
		time_asset[:media]="https://vine.co/v/b55LOA1dgJU"
		time_asset[:credit]=""
		time_asset[:caption]=""
		
		time_data={}
		time_data[:startDate]="2013,6,10"
		time_data[:endDate]="2013,7,10"
		time_data[:headline]="Vine"
		time_data[:text]="<p>Vine Test</p>"
		time_data[:asset]=time_asset
		
		time_date = []
		time_date << time_data

		selected_member.child_award_and_honours.where(:add_to_timeline=>true).each do |cah|
			time_asset[:media]=cah.photo.url(:large)
			time_asset[:credit]=""
			time_asset[:caption]=cah.title

			time_data[:startDate] = cah.award_date.year.to_s+","+cah.award_date.month.to_s+","+cah.award_date.day.to_s
			time_data[:endDate] = cah.award_date.year.to_s+","+cah.award_date.month.to_s+","+cah.award_date.day.to_s
			time_data[:headline] = cah.category
			time_data[:text] = "<p>#{cah.description}</p>"

			time_data[:asset] = time_asset

			time_date << time_data
		end
		selected_member.child_profile_activities.where(:add_to_timeline=>true).each do |cpa|
			time_asset[:media] = ""
			time_asset[:credit] = ""
			time_asset[:caption] = cpa.title

			time_data[:startDate] = cpa.start_date.year.to_s+","+cpa.start_date.month.to_s+","+cpa.start_date.day.to_s
			time_data[:endDate] = cpa.end_date.year.to_s+","+cpa.end_date.month.to_s+","+cpa.end_date.day.to_s
			time_data[:headline] = cpa.category
			time_data[:text] = "<p>#{cpa.description}</p>"
			
			time_data[:asset] = time_asset

			time_date << time_data
		end

		time_info = {}
		time_info[:headline] = "Nurtury Time Line"
		time_info[:type] = "default"
		time_info[:text] = "People say stuff"
		time_info[:startDate] = DateTime.now.year.to_s + "," + DateTime.now.month.to_s + "," + DateTime.now.day.to_s
		time_info[:date] = time_date

		time_line_data[:timeline] = time_info

		render :json=>time_line_data.to_json and return
	end
end
