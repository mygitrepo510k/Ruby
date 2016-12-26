class ChildFamilyActivitiesController < ApplicationController
  before_filter :authenticate_user!, :only => [:child_activities_list,:add_child_activities_list,:view_child_profile_photo,:view_single_test_report_photo]
  before_filter :check_current_user_member

  def check_current_user_member
    @user_family_member = current_user.family_members(FamilyMember::STATUS[:accepted]) if !current_user.blank?
  end

  def child_activities_list
    session[:show_variable_home] = 'Activities'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?        
    @family_member = selected_member
    #@child_profile_activities = @family_member.child_profile_activities
    @child_profile_activities = @family_member.cf_activity_upcomming_lists
  end
  
  def add_child_activities_list
    @family_member = selected_member
    @childprofileactivity = ChildProfileActivity.find(params[:test_report_id]) if !params[:test_report_id].blank?
    if request.post? || request.put?
      if @childprofileactivity.blank?
        @family_member.child_profile_activities.create(params[:test_reports])  
      else
        params[:test_reports][:school_activity] = 'false' if params[:test_reports][:school_activity].blank?
        params[:test_reports][:day_activity] = 'false' if params[:test_reports][:day_activity].blank?
        params[:test_reports][:add_to_timeline] = 'false' if params[:test_reports][:add_to_timeline].blank?
        params[:test_reports][:team_activity] = 'false' if params[:test_reports][:team_activity].blank?
        params[:test_reports][:repeat_activity] = 'false' if params[:test_reports][:repeat_activity].blank?
        params[:test_reports][:competitive] = 'false' if params[:test_reports][:competitive].blank?
        flash[:notice] = "Child activity successfully Added"
        @childprofileactivity.update_attributes(params[:test_reports])
      end
      #@child_profile_activities = @family_member.child_profile_activities
      @child_profile_activities = @family_member.cf_activity_upcomming_lists
      render :action => :child_activities_list and return
    end
    render :layout => false and return
  end

  def delete_child_activities_list
    @family_member = selected_member
    @childprofileactivity = ChildProfileActivity.find(params[:test_report_id])
    @childprofileactivity.destroy
    @child_profile_activities = @family_member.child_profile_activities
    flash[:notice] = "Child Profile Activity deleted successfully"
    render :action => :child_activities_list and return
  end

  def show_child_activities_list
    @family_member = selected_member
    if params[:check_order] == "Upcoming"
      @child_profile_activities = @family_member.cf_activity_upcomming_lists
    elsif params[:check_order] == "Past"
      @child_profile_activities = @family_member.cf_activity_past_lists
    elsif params[:check_order] == "All"
      @child_profile_activities = @family_member.child_profile_activities
    elsif params[:check_order] == "School"
      @child_profile_activities = @family_member.child_profile_activities.where(:school_activity=>true)
    elsif params[:check_order] == "Non-School"
      @child_profile_activities = @family_member.child_profile_activities.where(:school_activity=>nil)
    else
      @child_profile_activities = @family_member.child_profile_activities.order_by(" start_date #{check_order} ")
    end
    #@child_profile_activities = @family_member.child_profile_activities.order(" start_date #{check_order} ")
    render :layout => false,:partial => "show_child_activities_list" and return
  end

  def child_awards_and_honours
    session[:show_variable_home] = 'Awards & Honours'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_parent_id].nil? and params[:id].nil?
    session[:selected_parent_id] = params[:id] if params[:id].present?
    @family_member = selected_member
    @child_profile_awards = @family_member.child_award_and_honours
  end

  def view_child_profile_photo
    @award_honour = ChildAwardAndHonour.find(params[:award_honour_id])
    @show_title = "Awards & Honours"
    render :layout => false and return
  end

  def view_single_test_report_photo
    @award_honour = ChildProfileHealthTestReport.find(params[:test_report_id])
    @show_title = "Tests & Reports"
    render :action => 'view_child_profile_photo',:layout => false and return
  end
  

  def add_child_profile_awards
    @family_member = selected_member
    @child_profile_awards = ChildAwardAndHonour.find(params[:award_honour_id]) if !params[:award_honour_id].blank?
    if request.post? || request.put?
      if @child_profile_awards.blank?
        @family_member.child_award_and_honours.create(params[:test_reports])
        flash[:notice] = "Child Award And Honour created successfully"  
      else
        @child_profile_awards.update_attributes(params[:test_reports])
        flash[:notice] = "Child Award And Honour updated successfully"
      end
      @child_profile_awards = @family_member.child_award_and_honours.order_by(" award_date Desc ")
      render :action => :child_awards_and_honours and return
    end
    render :layout => false and return
  end

  def delete_child_profile_awards
    @family_member = selected_member
    @child_profile_award = ChildAwardAndHonour.find(params[:award_honour_id])
    @child_profile_award.destroy
    @child_profile_awards = @family_member.child_award_and_honours.order_by(" award_date Desc ")
    flash[:notice] = "Child Award And Honour deleted successfully"
    render :action => :child_awards_and_honours and return
  end

  def ha_filter
    opt = params[:opt]
    @family_member = selected_member
    if opt=="All"
      @child_profile_awards = @family_member.child_award_and_honours
    elsif opt=="Non-School"
      @child_profile_awards = @family_member.child_award_and_honours.reject{|e| e.from == 'School'}
    elsif opt=="School"
      @child_profile_awards = @family_member.ha_filter_data(opt)
    end
    render :layout => false,:partial => "ha_list" and return
  end

  def add_child_activities_outcome
    @family_member = selected_member
    @child_profile_activities = @family_member.child_profile_activities
    @child_profile_activity = ChildProfileActivity.find(params[:child_activity_id]) if !params[:child_activity_id].blank?
  #  if @child_profile_activity.child_activity_outcome.present?
    @activity_outcome = ChildActivityOutcome.find_by_child_profile_activity_id(params[:child_activity_id]) if !params[:child_activity_id].blank?

  #  end
    if request.post? || request.put?
      if @child_profile_activity.child_activity_outcomes.blank?
        @new_outcome = @child_profile_activity.child_activity_outcomes.create(params[:test_reports])
        @child_profile_activity.update_attribute('outcome',@new_outcome.status)
        flash[:notice] = "Child Activity Outcome added successfully"
        render :action => :child_activities_list and return
      else
        @activity_outcome = ChildActivityOutcome.find_by_child_profile_activity_id(params[:child_activity_id])
        @activity_outcome.update_attributes(params[:test_reports])
        flash[:notice] = "Child Activity Outcome Updated successfully"
        render :action => :child_activities_list and return
      end
    end
   render :layout => false and return 
  end

  def child_upcoming_exam
    session[:show_variable_home] = 'Exams'
    session[:dashboard] = 'child'
    redirect_to root_url  if session[:selected_member_id].nil? and params[:id].nil?
    session[:selected_member_id] = params[:id] if params[:id].present?
    @family_member = selected_member
    @child_exams = @family_member.child_profile_exams
  end

  def show_exam
    filter_opt = params[:opt]
    @family_member = selected_member
    if filter_opt == "Upcoming"
      @child_exams = @family_member.upcomming_child_profile_exams
    elsif filter_opt == "Past"
      @child_exams = @family_member.past_child_profile_exams
    elsif filter_opt == "School"
      @child_exams = @family_member.child_profile_exams.where(:school_exam=>true)
    elsif filter_opt == "Non-school"
      @child_exams = @family_member.child_profile_exams.where(:school_exam=>false)
    else
      @child_exams = @family_member.child_profile_exams
    end
    render :layout => false,:partial => "child_exam_list" and return
  end

  def create_exam
    @family_member = selected_member
    @class_names = @family_member.class_name_list
    @child_upcoming_exam = ChildProfileExam.find(params[:child_exam_id]) if !params[:child_exam_id].blank?
    if request.post? || request.put?
      if @child_upcoming_exam.blank?
        @family_member.child_profile_exams.create(params[:test_reports])
        flash[:notice] = "Child Exam created successfully"  
      else
        @child_upcoming_exam.update_attributes(params[:test_reports])
        flash[:notice] = "Child Exam Updated successfully"
      end
      @child_upcoming_exams = @family_member.child_profile_exams
      render :action => :child_upcoming_exam and return
    end
    render :layout => false and return
  end

  def delete_exam
    @family_member = selected_member
    @child_upcoming_exam = ChildProfileExam.find(params[:child_exam_id])
    @child_upcoming_exam.destroy
    @child_upcoming_exams = @family_member.child_profile_exams
    flash[:notice] = "Child Exam deleted successfully"
    render :action => :child_upcoming_exam and return
  end

  def create_exam_schedule
    if params[:exam_id].nil?
      redirect_to root_path
    end
    @curr_exam = ChildProfileExam.find(params[:exam_id])
    @class_names = selected_member.class_name_list
    if params[:schedule_id]
      if  @curr_exam.child_profile_exam_schedules.present?
        @child_exam_schedule ||= @curr_exam.child_profile_exam_schedules.find(params[:schedule_id])
      end
    else
      @child_exam_schedule = @curr_exam.child_profile_exam_schedules.build
    end
    if request.post? || request.put?
      if @child_exam_schedule.blank?
        @child_exam_schedule = @curr_exam.child_profile_exam_schedules.create(params[:exam_schedule])
        flash[:notice] = "Child Exam created successfully"  
      else
        @child_exam_schedule.update_attributes(params[:exam_schedule])
        flash[:notice] = "Child Exam Updated successfully"
      end
      #dt = @child_exam_schedule.start_date
      #st = DateTime.new(dt.year,dt.month,dt.day, params[:exam_schedule][:start_time].to_i,0,0)
      #et = DateTime.new(dt.year,dt.month,dt.day, params[:exam_schedule][:end_time].to_i,0,0)
      #@child_exam_schedule.start_time = st
      #@child_exam_schedule.end_time = et
      #@child_exam_schedule.end_time.save
      #render :text=>@child_exam_schedule.inspect and return
      @child_upcoming_exams = selected_member.child_profile_exams
      redirect_to child_upcoming_exam_path and return
    end
    render :layout => false and return
  end

  def delete_exam_schedule
    curr_exam = ChildProfileExamSchedule.find(params[:id])
    curr_exam.destroy
    flash[:notice] = "Child Exam Schedule deleted successfully"    
    render :nothing => true, :status=>200 and return
  end

  def child_exam_result
  end
end
